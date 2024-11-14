part of 'user_bloc.dart';

class UsersState extends Equatable {
  final PostStatus status;
  final List<UserModel> users;
  final List<UserModel> searchedUsers;
  final String message;
  final bool isSearching;
  const UsersState({
    this.status = PostStatus.loading,
    this.users = const [],
    this.searchedUsers = const [],
    this.isSearching = false,
    this.message = 'loading ...',
  });

  @override
  List<Object> get props => [
        status,
        users,
        message,
        searchedUsers,
        isSearching,
      ];

  UsersState copyWith({
    PostStatus? status,
    List<UserModel>? users,
    List<UserModel>? searchedUsers,
    String? message,
    bool? isSearching,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      searchedUsers: searchedUsers ?? this.searchedUsers,
      message: message ?? this.message,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
