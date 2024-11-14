import 'dart:developer';
import 'package:bloc_practice/logic/bloc/post_bloc/post_bloc.dart';
import 'package:bloc_practice/logic/model/post_model.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Get(Posts) Api Bloc'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (__, state) {
          log(state.posts.toString());
          switch (state.status) {
            case PostStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostStatus.failure:
              return const Center(
                child: Text(
                  'No Posts Available',
                ),
              );
            default:
              return buildPostsUi(context, state.posts);
          }
        },
      ),
    );
  }

  Widget buildPostsUi(
    BuildContext context,
    List<Post> posts,
  ) {
    if (posts.isEmpty) {
      return const Center(
        child: Text(
          'No Posts Available',
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        separatorBuilder: (_, i) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (_, i) => postTile(_, posts[i]),
        itemCount: posts.length,
      );
    }
  }

  Widget postTile(BuildContext context, Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  post.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  post.body ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
