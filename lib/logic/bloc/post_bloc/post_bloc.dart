import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/repository/post_repositroy.dart';
import 'package:bloc_practice/logic/model/post_model.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postsRepo;
  PostBloc(this.postsRepo) : super(const PostState()) {
    on<FetchPosts>(fetchPosts);
  }

  Future<void> fetchPosts(FetchPosts event, Emitter<PostState> emit) async =>
      await postsRepo
          .fetchPosts()
          .then(
            (post) => emit(
              state.copyWith(
                status: PostStatus.success,
                posts: post,
                message: 'Posts Successfully fetched',
              ),
            ),
          )
          .onError(
            (error, stackTrace) => emit(
              state.copyWith(
                status: PostStatus.failure,
                message: 'Error occured while fetching posts',
              ),
            ),
          );
}
