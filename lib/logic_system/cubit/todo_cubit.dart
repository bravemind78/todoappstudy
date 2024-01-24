// ignore_for_file: unnecessary_import, prefer_const_constructors, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/logic_system/cubit/todo_state.dart';
import 'package:todoapp/presentation/screens/archived_tasks_screen.dart';
import 'package:todoapp/presentation/screens/done_task_screen.dart';
import 'package:todoapp/presentation/screens/new_task_screen.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());
  static TodoCubit get(context) => BlocProvider.of(context);
  /* -------------------------------------------------------------------------- */
  /*                             Variables Definitios                            */
  /* -------------------------------------------------------------------------- */

  /* ----------------------- Text Controller Definitions ---------------------- */
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
/* -------------------------- GlobalKey Definitions and Database ------------------------- */
  GlobalKey<ScaffoldState> scafoldkey = GlobalKey();
  GlobalKey<FormState> formkey = GlobalKey();
  late Database database;
  /* ---------------------------- List Definitions ---------------------------- */
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchivedTaskScreen()
  ];
  List<Icon> icons = [Icon(Icons.add), Icon(Icons.check), Icon(Icons.archive)];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  List<Color> screenColor = [Colors.blue, Colors.green, Colors.red];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
/* -------------------- Conditions variables Definitions -------------------- */
  bool isButtomSheetVisible = false;

  /* -------------------------------------------------------------------------- */
  /*                             Building Functions                             */
  /* -------------------------------------------------------------------------- */

  /* ------------------------ Change the current Index ------------------------ */
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  /* ---------------- Change the Icon of Floating Action Button --------------- */
  changeFloatingActionButtonIcon() {
    if (isButtomSheetVisible) {
      emit(ShowButtomSheetVisibleState());
      return Icon(Icons.add);
    } else {
      emit(ShowButtomSheetVisibleState());
      return Icon(Icons.edit);
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                         Building DataBase Functions                        */
  /* -------------------------------------------------------------------------- */

/* ------------------------ Create Database Function ------------------------ */
  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE tasktable(id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)')
            .then((value) {
          emit(CreatDataBaseTableSucceedState());
          print("table created successfully");
        }).catchError((onError) {
          emit(CreatDataBaseTableErrorState(onError.toString()));
          print('error while creating table is $onError');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print("database opened successfully");
      },
    ).then((value) {
      emit(CreateDataBaseSucceedState());
      return database = value;
    });
  }

  /* ----------------------- Insert raws inside DataBase ---------------------- */
  Future insertRaws({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
              "INSERT INTO tasktable(title,time,date,status)VALUES('$title','$time','$date','new')")
          .then((value) {
        emit(InsertDataBaseRawSucceedState());
        print('raw inserted successfully: $value');
      }).catchError((onError) {
        emit(InsertDataBaseRawErrorState(onError.toString()));
      });
    });
  }

  /* ----------------------- Get the Data From DataBase ----------------------- */
  void getDataFromDataBase(database) {
    emit(GetDataFromDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasktable').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(GetDataFromDataBaseSucceedState());
      titleController.clear();
      timeController.clear();
      dateController.clear();
    });
  }
  /* -------------------------------------------------------------------------- */
}
