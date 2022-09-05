import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_pp/shared/Cubit/cubit.dart';
import 'package:new_pp/shared/Cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/archivedtasks/archivedtasksScreen.dart';
import '../../modules/donetasks/donetasksScreen.dart';
import '../../modules/new_tasks/newtasksScreen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class HomeLayout extends StatelessWidget{

  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();

  var titleControler=TextEditingController();
  var timeControler=TextEditingController();
  var dateControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
         listener: (BuildContext context,AppStates state)
         {
           if(state is AppInsertDatabaseState)
             {
               Navigator.pop(context);
             }
         },
          builder:(BuildContext context,AppStates state) {
           AppCubit Cubit=AppCubit.get(context);
           return Scaffold(
             key:scaffoldKey,

             appBar: AppBar(
               // leading: Icon(Icons.add_box_rounded),
               title: Center(child: Text(Cubit.titles[Cubit.currentindex])),
               /*actions: [
              Icon(Icons.add_box_rounded),
              Text('newww',
                style: TextStyle(
                  color: Colors.blue,
                ),),
            ],*/
             ),

             floatingActionButton: FloatingActionButton(
               onPressed: () {
                 if(Cubit.isBottomSheetShown){
                   if(formKey.currentState.validate())
                   {
                     Cubit.insertDatabase(
                        title:titleControler.text,
                        time: timeControler.text,
                        date: dateControler.text,
                     );
                   }
                 }else {
                   scaffoldKey.currentState.showBottomSheet((context) =>
                       Container(
                         color: Colors.grey[150],
                         padding: EdgeInsets.all(20.6),
                         child: Form(
                           key: formKey,
                           child: Column(

                               mainAxisSize: MainAxisSize.min,
                               children: [

                                 defaultFormField(
                                   validate: (String value) {
                                     if (value.isEmpty) {
                                       return "type title of task";
                                     }
                                     return null;
                                   },
                                   controller: titleControler,
                                   type: TextInputType.text,
                                   label: 'title',
                                   prefix: Icons.title,


                                 ),
                                 SizedBox(
                                   height: 20.3,
                                 ),
                                 defaultFormField(
                                   onTap: () {
                                     showTimePicker(
                                       context: context,
                                       initialTime: TimeOfDay.now(),

                                     ).then((value) {
                                       timeControler.text =
                                           value.format(context).toString();
                                     }
                                     );
                                   },
                                   validate: (String value) {
                                     if (value.isEmpty) {
                                       return "type task";
                                     }
                                     return null;
                                   },
                                   controller: timeControler,
                                   type: TextInputType.text,
                                   label: 'task',
                                   prefix: Icons.watch,


                                 ),
                                 SizedBox(
                                   height: 20.3,
                                 ),
                                 /*3*/defaultFormField(
                                   onTap: () {
                                     showDatePicker(
                                       initialDate: DateTime.now(),
                                       firstDate: DateTime.now(),
                                       lastDate: DateTime.parse("2022-09-10"),
                                       context: context,
                                     ).then((value) {
                                       dateControler.text =
                                           DateFormat.yMMMd().format(value);
                                     }
                                     );
                                   },
                                   validate: (String value) {
                                     if (value.isEmpty) {
                                       return "type date";
                                     }
                                     return null;
                                   },
                                   controller: dateControler,
                                   type: TextInputType.text,
                                   label: 'date',
                                   prefix: Icons.date_range,


                                 ),
                               ]
                           ),
                         ),
                       )
                   ).closed.then((value) {
                   Cubit.ChangeBottomSheetState(isShwon: false,icon: Icons.edit,);
                   });

                   Cubit.ChangeBottomSheetState(isShwon: true,icon: Icons.add,);

                 }
               },
               child:Icon(Cubit.ForIcon),
               mini: true,
             ),
             body:ConditionalBuilder(
               condition:state is! AppGetDatabaseLoadingState,
               builder:(context)=>Cubit.screens[Cubit.currentindex],
               fallback:(context)=>Center(child:LinearProgressIndicator(),),
             ),

             bottomNavigationBar: BottomNavigationBar(
                 currentIndex:Cubit.currentindex ,
                 backgroundColor: Colors.white70,
                 //elevation: 2.5,
                 onTap: (index) {
                   Cubit.changeIndex(index);
                 },
                 items: [
                   BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'New',),
                   BottomNavigationBarItem(icon:Icon(Icons.check_box,color: Colors.green,),label:'Done',),
                   BottomNavigationBarItem(icon:Icon(Icons.archive,color: Colors.grey[800],),label:'Archived',),
                 ]),
           );
         }
      ),
    );
  }

}
