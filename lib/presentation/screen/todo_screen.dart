import 'package:bloc_practice/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo Bloc'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (__, state) {
          if (state.todos.isEmpty) {
            return const Center(
              child: Text(
                'No Tasks to do', 
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              separatorBuilder: (_, i) => const SizedBox(
                height: 20,
              ),
              itemBuilder: (_, i) => todoTile(_, state.todos[i]),
              itemCount: state.todos.length,
            );
          }
        },
      ),
      floatingActionButton: IconButton(
        onPressed: () => addTodoDialog(context),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  dynamic addTodoDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              height: 200,
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: taskController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (taskController.text.isEmpty) {
                            return;
                          } else {
                            context
                                .read<TodoBloc>()
                                .add(AddTodo(taskController.text));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Add",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget todoTile(BuildContext context, String todo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          todo,
        ),
        IconButton(
          onPressed: () => context.read<TodoBloc>().add(RemoveTodo(todo)),
          icon: const Icon(
            Icons.delete,
          ),
        ),
      ],
    );
  }
}
