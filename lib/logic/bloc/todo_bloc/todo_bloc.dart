import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<String> todos = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodo>(addTodo);
    on<RemoveTodo>(removeTodo);
  }

  void addTodo(AddTodo event, Emitter<TodoState> emit) {
    todos.add(event.todo);
    emit(state.copyWith(todos: List.from(todos)));
  }

  void removeTodo(RemoveTodo event, Emitter<TodoState> emit) {
    todos.remove(event.todo);
    emit(state.copyWith(todos: List.from(todos)));
  }
}
