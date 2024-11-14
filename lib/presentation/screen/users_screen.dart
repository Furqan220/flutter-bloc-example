import 'package:bloc_practice/logic/bloc/user_bloc/user_bloc.dart';
import 'package:bloc_practice/logic/model/user_model.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Get(Posts) Api Bloc'),
      ),
      body: BlocBuilder<UserBloc, UsersState>(
        builder: (__, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostStatus.failure:
              return Center(
                child: Text(
                  state.message.isNotEmpty
                      ? state.message
                      : 'No Users Available',
                ),
              );
            default:
              return buildUsersUi(context, state);
          }
        },
      ),
    );
  }

  Widget buildUsersUi(
    BuildContext context,
    UsersState state,
  ) {
    if (state.users.isEmpty) {
      return const Center(
        child: Text(
          'No Users Available',
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 05,
                horizontal: 05,
              ),
              child: TextFormField(
                onChanged: (query) =>
                    context.read<UserBloc>().add(SearchUserByName(query)),
                decoration: InputDecoration(
                  hintText: 'Search by name ...',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: state.isSearching
                ? showSearchResults(
                    context,
                    state.searchedUsers,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    separatorBuilder: (_, i) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (_, i) => userTile(_, state.users[i]),
                    itemCount: state.users.length,
                  ),
          ),
        ],
      );
    }
  }

  Widget showSearchResults(
      BuildContext context, List<UserModel> searchedUsers) {
    return searchedUsers.isEmpty
        ? const Center(
            child: Text(
              'No Users Available',
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            separatorBuilder: (_, i) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (_, i) => userTile(_, searchedUsers[i]),
            itemCount: searchedUsers.length,
          );
  }

  Widget userTile(BuildContext context, UserModel user) {
    return Container(
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
              user.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 300,
            child: Text(
              user.email ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
