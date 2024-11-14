part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {}

class SearchUserByName extends UserEvent {
  final String query;
  const SearchUserByName(this.query);

  @override
  List<Object> get props => [query];
}
