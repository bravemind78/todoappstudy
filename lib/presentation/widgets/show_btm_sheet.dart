// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/logic_system/cubit/todo_cubit.dart';
import 'package:todoapp/logic_system/cubit/todo_state.dart';
import 'package:todoapp/presentation/widgets/text_form_field.dart';

Widget showBtnSheetView() => BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Container(
            padding: EdgeInsets.all(15),
            color: Colors.grey,
            width: double.infinity,
            child: Form(
              key: cubit.formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultFormField(
                      controller: cubit.titleController,
                      type: TextInputType.name,
                      prefix: Icons.title,
                      label: 'Enter Task Title',
                      hintText: 'Enter Task Title',
                      validate: (value) {
                        if (value.isEmpty) {
                          return "title cant't be empty";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: cubit.timeController,
                      type: TextInputType.name,
                      prefix: Icons.access_time_rounded,
                      label: 'Enter Task Time',
                      hintText: 'Enter Task Time',
                      validate: (value) {
                        if (value.isEmpty) {
                          return "Time cant't be empty";
                        }
                        return null;
                      },
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          cubit.timeController.text =
                              value!.format(context).toString();
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: cubit.dateController,
                    type: TextInputType.name,
                    prefix: Icons.date_range_outlined,
                    label: 'Enter Task Date',
                    hintText: 'Enter Task Date',
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.parse('2030-01-01'),
                      ).then((value) {
                        cubit.dateController.text =
                            DateFormat.yMMMd().format(value!);
                      });
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return "Date cant't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ));
      },
    );
