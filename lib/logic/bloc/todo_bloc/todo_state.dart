part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<String> todos;
  const TodoState({this.todos = const []});

  @override
  List<Object> get props => [todos];

  TodoState copyWith({List<String>? todos}) =>
      TodoState(todos: todos ?? this.todos);
}
