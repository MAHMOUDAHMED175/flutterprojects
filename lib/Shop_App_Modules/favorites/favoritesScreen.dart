


//hello
//hello

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/shopModels/favoritesModels/favoritesModels.dart';

import '../../Shop_App_layout/cubitShop/cubitShop.dart';
import '../../Shop_App_layout/cubitShop/statesShop.dart';
import '../../shared/styles/colors.dart';
class favoritesScreen extends StatelessWidget {
 FavoritesModel favoritesModel;
  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:state is! shopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>BuildItemFavorites(shopCubit.get(context).favoritesModel.data.data[index],context),
            separatorBuilder: (context,index)=>SizedBox(
              height: 10.0,
            ),
            itemCount: shopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget BuildItemFavorites(FavoritesData model, context){

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image:NetworkImage(model.product.image),
                  // fit:BoxFit.cover,
                  height:150.0,
                  width:150.0,
                ),
                if(model.product.discount !=0)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),

                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 14.0,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product.price.round()}',
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14.0,
                          height: 2.0,
                          color: dafultColor,
                        ),
                      ),
                      SizedBox(
                        width:10.0,
                      ),
                      if(model.product.discount!=0)
                        Text(
                          '${model.product.oldPrice.round()}',//علشان يدينى رقم  integer
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,// علشان اعمل خط على السعر القديم
                            fontSize: 12.0,
                            height: 2.0,
                            color: Colors.grey[500],
                          ),
                        ),
                      Spacer(),//علشان اودى العنصر اللى  بعده للاخر وافصل مابين اللى قبله واللى بعده بمسافه كwidth
                      IconButton(
                        onPressed: (){
                          shopCubit.get(context).ChgangeFavorites(model.product.id);

                        },
                        icon: CircleAvatar(
                          radius: 16.0,
                          backgroundColor :shopCubit.get(context).favorites[model.product.id]?Colors.blue:Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 20.0,
                            color: Colors.grey[200],
                          ),
                        ),),

                    ],
                  ),

                ],
              ),
            ),


          ],

        ),
      ),
    );
  }
}
