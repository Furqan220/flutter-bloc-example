import 'package:bloc_practice/data/repository/post_repositroy.dart';
import 'package:bloc_practice/data/repository/product_repository.dart';
import 'package:bloc_practice/data/repository/users_repository.dart';
import 'package:bloc_practice/logic/bloc/counter_bloc/counter_bloc.dart';
import 'package:bloc_practice/logic/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:bloc_practice/logic/bloc/post_bloc/post_bloc.dart';
import 'package:bloc_practice/logic/bloc/product_bloc/product_bloc.dart';
import 'package:bloc_practice/logic/bloc/switch_bloc/switch_bloc.dart';
import 'package:bloc_practice/logic/bloc/todo_bloc/todo_bloc.dart';
import 'package:bloc_practice/logic/bloc/user_bloc/user_bloc.dart';
import 'package:bloc_practice/presentation/screen/index_screen.dart';
import 'package:bloc_practice/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
        // we are going to use this bloc only for specific not globally
        // BlocProvider(
        //   create: (context) => CounterBloc(),
        // ),
        BlocProvider(
          create: (context) => TodoBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRepository()),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(ImagePickerUtils()),
        ),
        BlocProvider(
          create: (context) => PostBloc(PostRepository()),
        ),
        BlocProvider(
          create: (context) => UserBloc(UsersRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const IndexScreen(),
      ),
    );

    /*
     return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (_) => CounterBloc(),
        ),
        BlocProvider<SwitchBloc>(
          create: (_) => SwitchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const IndexScreen(),
      ),
    );
     */
  }
}
