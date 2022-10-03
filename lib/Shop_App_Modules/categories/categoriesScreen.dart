import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shop_App_layout/cubitShop/cubitShop.dart';
import '../../Shop_App_layout/cubitShop/statesShop.dart';
import '../../shopModels/categoritesModels/categoritesModels.dart';
class categoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildCategoriesItem(shopCubit.get(context).categoriesModels.data.data[index]),
            separatorBuilder: (context,index)=>SizedBox(
              height: 10.0,
            ),
            itemCount: shopCubit.get(context).categoriesModels.data.data.length,
        );
      },
    );
  }
  Widget buildCategoriesItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image:NetworkImage(model.image),
            height: 100.0,
            width: 100.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
              Icons.arrow_forward_ios
          )
        ],
      ),
    );
  }
}
