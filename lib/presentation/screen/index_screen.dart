import 'dart:developer';

import 'package:bloc_practice/logic/model/person_model/person_model.dart';
import 'package:bloc_practice/presentation/screen/counter_screen.dart';
import 'package:bloc_practice/presentation/screen/image_picker_screen.dart';
import 'package:bloc_practice/presentation/screen/login_screen.dart';
import 'package:bloc_practice/presentation/screen/posts_screen.dart';
import 'package:bloc_practice/presentation/screen/products_screen.dart';
import 'package:bloc_practice/presentation/screen/switch_screen.dart';
import 'package:bloc_practice/presentation/screen/todo_screen.dart';
import 'package:bloc_practice/presentation/screen/users_screen.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 100,
          horizontal: 30,
        ),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CounterScreen(),
              ),
            ),
            child: const Text('Counter Bloc'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SwitchScreen(),
              ),
            ),
            child: const Text('Switch Bloc'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ImagePickerScreen(),
              ),
            ),
            child: const Text('Image Picker Bloc'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TodoScreen(),
              ),
            ),
            child: const Text('Todo Bloc'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProductsScreen(),
              ),
            ),
            child: const Text('Favourite App Bloc'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PostsScreen(),
              ),
            ),
            child: const Text('Get(Posts) Api Bloc'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UsersScreen(),
              ),
            ),
            child: const Text('Get(Users) Search Functionality'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            ),
            child: const Text('Post Api(Login)'),
          ),
          ElevatedButton(
            onPressed: () {
              log('print person');

              final person1 = Person.fromJson({'first_name': 'Furqan'});
              const person2 = Person(firstName: 'Furqan', lastName: 'Ahmed');

              log('person 1 $person1');
              log('person 2  $person2');
              log('person is same ${person1 == person2}');
            },
            child: const Text('Person model'),
          ),
        ],
      ),
    );
  }
}
