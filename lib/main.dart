import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/logic_system/cubit/todo_cubit.dart';
import 'package:todoapp/presentation/screens/layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
      // ignore: prefer_const_constructors
      child: MaterialApp(
        // ignore: prefer_const_constructors
        home: LayOutScreen(),
      ),
    );
  }
}
