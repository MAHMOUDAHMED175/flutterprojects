import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/layout/news_app/cubit/cubit.dart';
import 'package:new_pp/modules/search/search_screen.dart';
import 'package:new_pp/shared/network/remote/dio_helper.dart';
import '../../shared/Cubit/cubit.dart';
import '../../shared/components/components.dart';
import 'cubit/states.dart';
class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder:(context,state){
          var cubit=NewsCubit.get(context);
          return Scaffold(
    appBar: AppBar(
    title: Text('News Today',),
    actions:[
    IconButton(
      icon:const Icon(
        Icons.search,
        size: 28.2,
      ),
      onPressed:(){
        navigatorTo(context,SearchScreen());
      },
    ),
    IconButton(
      icon:const Icon(
        Icons.brightness_4_outlined,
        size: 28.3,
      ),
      onPressed:(){
       AppCubit.get(context).changeAppMode();
      },
    )
    ],

    ),
    body: cubit.screen[cubit.currentIndex],
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: cubit.currentIndex,
    onTap: (index){
           cubit.changeBottomVavBar(index);
    },
    items:cubit.bottomItem,
    ),
    );
        },


    );
  }
}
