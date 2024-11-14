part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final String todo;
  const AddTodo(this.todo);
  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final String todo;
  const RemoveTodo(this.todo);
  @override
  List<Object> get props => [todo];
}
