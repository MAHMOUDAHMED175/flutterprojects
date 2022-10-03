
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/on_boarding/on_boarding_screen.dart';
import 'package:new_pp/Shop_App_Modules/shop_login/login.dart';
import 'package:new_pp/Shop_App_layout/cubitShop/cubitShop.dart';
import 'package:new_pp/Shop_App_layout/shopLayout.dart';
import 'package:new_pp/TODO_APP_modules/Cubit/cubit.dart';
import 'package:new_pp/TODO_APP_modules/Cubit/states.dart';
import 'package:new_pp/shared/blocOpserver.dart';
import 'package:new_pp/shared/network/local/cache_helper/cacheHelper.dart';
import 'package:new_pp/shared/network/remote/dio_helper.dart';
import 'package:new_pp/shared/styles/themes.dart';

import 'layout/news_app_layout/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();// عملت كدا علشان استخدمت ال await  مع ال main  والميثود دى بتضمن ان كل الحاجات اللى قبل ال run  تتنفذ وال wait تتنفذ الاول
  // if(Platform.isWindows)
  //await DesktopWindow.setMinWindowSize(Size(600,600));
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
 // await Firebase.initializeApp();

  bool isDark=CacheHelper.getData(key: 'isDark');
  bool onBoarding=CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  String token=CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding !=null){
    if(token!=null){
      widget=shopLayout();
    }else{
      widget=shopLogin();
    }

  }else{
    widget=OnBoardingScreen();
  }
  runApp(NewApp(
    isDark: isDark,
    startWidget: widget,
  ));
}
class NewApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

   NewApp({
     this.isDark,
     this.startWidget,
}

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
        BlocProvider(create: (BuildContext context) =>shopCubit()..getHomeData()..getCategories()..getFavorites()..getProfile(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightThem,
            darkTheme:darkThem,
           themeMode: AppCubit.get(context).isDark?ThemeMode.light:ThemeMode.dark,

            home:startWidget,

            // Directionality(
            // textDirection: TextDirection.rtl,
            //      child:
            //
            // ) ,
            //
            // debugShowCheckedModeBanner: false,// Image(image:NetwokImage('images/2022-01-19_06-29-41-33803e677e5b58cfcf6c40e60220beb3.png'),) ,
          );
        },
        ),
    );
  }
}
