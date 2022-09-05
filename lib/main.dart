import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_pp/layout/news_app/cubit/cubit.dart';
import 'package:new_pp/layout/news_app/cubit/states.dart';
import 'package:new_pp/layout/news_app/news_layout.dart';
import 'package:new_pp/layout/todo_app/TodoLayout.dart';
import 'package:new_pp/modules/bmi/BMIScreen.dart';
import 'package:new_pp/modules/counter/COunterScreen.dart';
import 'package:new_pp/modules/native_code.dart';
import 'package:new_pp/modules/new_tasks/newtasksScreen.dart';
import 'package:new_pp/shared/Cubit/states.dart';
import 'package:new_pp/shared/blocOpserver.dart';
import 'package:new_pp/shared/network/local/cache_helper/cacheHelper.dart';
import 'package:new_pp/shared/network/remote/dio_helper.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'modules/login/login_screen.dart';
import 'shared/Cubit/cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();// عملت كدا علشان استخدمت ال await  مع ال main  والميثود دى بتضمن ان كل الحاجات اللى قبل ال run  تتنفذ وال wait تتنفذ الاول
  // if(Platform.isWindows)
  //await DesktopWindow.setMinWindowSize(Size(600,600));
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark=CacheHelper.getBoolean(key: 'isDark');
  runApp(NewApp(isDark));
}
class NewApp extends StatelessWidget {
  final bool isDark;
   NewApp(
       this.isDark,
       );



//
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>NewsCubit()..getPolicy()..getBusiness()..getSports()..getScience()..getTechnology()..getEntertainment(),
          // علشان استدعى البيانات بتاعت التلت شاشات مع بعض
        ),
        BlocProvider(create: (BuildContext context) =>AppCubit()..changeAppMode(alSavedFromCache:isDark),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context,state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,

              theme:ThemeData(
                primarySwatch: Colors.orange,//علشان يغير لون اللودنج وهيا بتلف لبرتقالى
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey.withOpacity(0.28),
                      statusBarIconBrightness:Brightness.dark
                  ),
                  backgroundColor: Colors.white,
                  elevation:0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                  iconTheme:IconThemeData(
                    color: Colors.black,
                  ) ,
                ),
                textTheme:TextTheme(
                  bodyText1:TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ) ,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrangeAccent,
                  unselectedItemColor: Colors.grey,
                  elevation: 3.0,
                  backgroundColor: Colors.white,
                )
            ),
            darkTheme:ThemeData(
                scaffoldBackgroundColor: HexColor('375563'),

                primarySwatch: Colors.orange,//علشان يغير لون اللودنج وهيا بتلف لبرتقالى
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey.withOpacity(0.28),
                      statusBarIconBrightness:Brightness.light
                  ),
                  backgroundColor:HexColor('375563'),
                  elevation:0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                  iconTheme:IconThemeData(
                    color: Colors.white,
                  ) ,
                ),
                textTheme:TextTheme(
                  bodyText1:TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ) ,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrangeAccent,
                  unselectedItemColor: Colors.grey,
                  elevation: 3.0,
                  backgroundColor: HexColor('375563'),
                )
            ),
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home:NewsLayout(),

            //Directionality(
            //textDirection: TextDirection.rtl,
            //      child:

            // ) ,
            //
            // debugShowCheckedModeBanner: false,// Image(image:NetwokImage('images/2022-01-19_06-29-41-33803e677e5b58cfcf6c40e60220beb3.png'),) ,
          );
        },
        ),
    );
  }
}
