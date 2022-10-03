

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/TODO_APP_modules/Cubit/states.dart';
import 'package:new_pp/shared/network/local/cache_helper/cacheHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../../TODO_APP_modules/archivedtasks/archivedtasksScreen.dart';
import '../../TODO_APP_modules/donetasks/donetasksScreen.dart';
import '../../TODO_APP_modules/new_tasks/newtasksScreen.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<String> titles = [
    'NewTasks',
    'DoneTasks',
    'ArchivedTasks',
  ];

  int currentindex = 0;
  List<Map> newwTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  Database database;

  List<Widget> screens = [
    newtasksScreen(),
    donetasksScreen(),
    archivedtasksScreen(),
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'someTasks.db',
      version: 1,
      onCreate: (database, version) {
        print("congratulation database is created");
        database.execute(
            'CREATE TABLE newTasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)'
        ).then((value) {
          print('table is created');
        }).catchError((error) {
          print('errror when create table');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print("congratulation database is opend");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    return await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO newTasks(title,time,date,status)VALUES("$title","$time","$date","new")'
      ).then((value) {
        emit(AppInsertDatabaseState());
        print("values inserted successfully");
        getDataFromDatabase(database);

      }).catchError((error) {
        print("error when inserted database");
      });

      return null;
    });
  }

  void   getDataFromDatabase(database){
    newwTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM newTasks').then((value) {
      value.forEach((element){
         if(element['status'] == 'new') {
           newwTasks.add(element);
         } else if(element['status'] == 'done') {
           doneTasks.add(element);
         } else {
           archivedTasks.add(element);
         }
        print(element['status']);
      });
      emit(AppGetDatabaseState());
    });
  }
  void Updatedata(
      String status,
      int id,
      )async{
    database.rawUpdate('UPDATE newTasks SET status=? WHERE id=?',
      [status,id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }
  void Deletedata(
      int id,
      )async{
    database.rawDelete('DELETE  FROM newTasks WHERE id=?', [id],).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
  bool isBottomSheetShown = false;
  IconData ForIcon = Icons.edit;
  void ChangeBottomSheetState ({
  @required isShwon,
  @required icon ,
})
  {
    isBottomSheetShown=isShwon;
    ForIcon=icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark=false;
  void changeAppMode({bool alSavedFromCache}){
     if(alSavedFromCache!=null)
       {
         isDark=alSavedFromCache;
         emit(AppChangeModeState());
       }
    else
      {
        isDark=!isDark;
        CacheHelper.putBoolean(key:'isDark',value:isDark).then((value) {
          emit(AppChangeModeState());

        }
        );
      }


  }
}





