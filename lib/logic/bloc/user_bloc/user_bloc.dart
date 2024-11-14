import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/repository/users_repository.dart';
import 'package:bloc_practice/logic/model/user_model.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UsersState> {
  List<UserModel> _searchUser = [];
  final UsersRepository postsRepo;
  UserBloc(this.postsRepo) : super(const UsersState()) {
    on<FetchUsers>(fetchUsers);
    on<SearchUserByName>(filterUsersByName);
  }

  Future<void> fetchUsers(FetchUsers event, Emitter<UsersState> emit) async =>
      await postsRepo
          .fetchUsers()
          .then(
            (post) => emit(
              state.copyWith(
                status: PostStatus.success,
                users: post,
                message: 'Users Successfully fetched',
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

  Future<void> filterUsersByName(
      SearchUserByName event, Emitter<UsersState> emit) async {
    if (event.query.isEmpty) {
      _searchUser = [];
      emit(
        state.copyWith(
          isSearching: false,
          searchedUsers: List.from(_searchUser),
        ),
      );
    } else {
      _searchUser = state.users
          .where(
            (user) => (user.name ?? '')
                .toLowerCase()
                .contains(event.query.toLowerCase()),
          )
          .toList();
      emit(
        state.copyWith(
          isSearching: true,
          searchedUsers: List.from(_searchUser),
        ),
      );
    }
  }

  

}
