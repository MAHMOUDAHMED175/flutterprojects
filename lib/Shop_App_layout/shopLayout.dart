import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/search/searchScreen.dart';
import 'package:new_pp/shared/components/components.dart';
import 'cubitShop/cubitShop.dart';
import 'cubitShop/statesShop.dart';
class shopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    var cubit=shopCubit.get(context);
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context,state){},
     builder: (context,state){
       return Scaffold(
         appBar: AppBar(
           title: Text(
             "TASAOQ",
           style: TextStyle(
             color: Colors.deepOrangeAccent
           ),
           ),
           actions: [
             IconButton(onPressed: (){
               navigatorTo(context, searchScreen());
             }, icon: Icon(Icons.search,),),
           ],
         ),
         body:cubit.bottomScreen[cubit.curruntIndex],
         bottomNavigationBar: CurvedNavigationBar(
           onTap: (index){
             cubit.changeBottom(index);
           },
           backgroundColor: Colors.white,
           buttonBackgroundColor: Colors.blue,
           color: Colors.orange.withOpacity(0.9),
           height: 50.0,
           animationCurve: Curves.easeInCirc,
           animationDuration: Duration(
             milliseconds: 20,
           ),
           index: cubit.curruntIndex,
           items:<Widget> [
             Icon(Icons.production_quantity_limits,color: Colors.white,),
             Icon(Icons.apps,color: Colors.white,),
             Icon(Icons.favorite,color: Colors.white,),
             Icon(Icons.settings,color: Colors.white,),

           ],
         ),



         //
         // BottomNavigationBar(
         //   onTap: (index){
         //     cubit.changeBottom(index);
         //   },
         //   currentIndex: cubit.curruntIndex,
         //   items: [
         //     BottomNavigationBarItem(
         //       icon: Icon(Icons.production_quantity_limits),
         //       label: 'products',
         //     ),
         //     BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'categories',),
         //     BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favorites',),
         //     BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings',),
         //
         //   ],
         // ),











       );
     },

    );
  }
}
