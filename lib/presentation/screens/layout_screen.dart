// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/logic_system/cubit/todo_cubit.dart';
import 'package:todoapp/logic_system/cubit/todo_state.dart';
import 'package:todoapp/presentation/widgets/show_btm_sheet.dart';

class LayOutScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  LayOutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Scaffold(
          key: cubit.scafoldkey,
          appBar: AppBar(
            backgroundColor: cubit.screenColor[cubit.currentIndex],
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          floatingActionButton: FloatingActionButton(
            child: cubit.changeFloatingActionButtonIcon(),
            onPressed: () {
              if (cubit.isButtomSheetVisible &&
                  cubit.formkey.currentState!.validate()) {
                cubit.insertRaws(
                    title: cubit.titleController.text,
                    time: cubit.timeController.text,
                    date: cubit.dateController.text);
                Navigator.pop(context);
                cubit.isButtomSheetVisible = false;
              } else {
                cubit.scafoldkey.currentState!
                    .showBottomSheet((context) => showBtnSheetView());
                cubit.isButtomSheetVisible = true;
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Task'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check), label: 'Done Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'Archived Tasks'),
            ],
            onTap: (value) {
              cubit.changeCurrentIndex(value);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
