import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/shared/components/components.dart';
import 'package:new_pp/shared/styles/colors.dart';

import '../../Shop_App_layout/cubitShop/cubitShop.dart';
import '../../Shop_App_layout/cubitShop/statesShop.dart';
import '../../shopModels/HomeModels/HomeModels.dart';
import '../../shopModels/categoritesModels/categoritesModels.dart';
class productsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context,state){
        if(state is shopSuccessChangeFavoritesState)
          {
            if(!state.model.status)
              {
                showToast(
                    text: state.model.message,
                    state: ToastStates.ERROR,
                );
              }
          }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition:shopCubit.get(context).homeModel!=null&&shopCubit.get(context).categoriesModels!=null,
          builder:(context)=> productsBuilder(shopCubit.get(context).homeModel,shopCubit.get(context).categoriesModels,context),
          fallback: (context)=> Center(child: CircularProgressIndicator(),),

        );

      },
    );
  }
  Widget  productsBuilder(HomeModel model,CategoriesModels categoriesModels,BuildContext context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //دى علشان أعرض صور وتتحرك ورى بعض لوحدها اسمها banners
          CarouselSlider(
            items: model.data.banners.map((e) =>Image(
              image: NetworkImage('${e.image}',),
              fit: BoxFit.cover,
              width:double.infinity,
            ),).toList(),
            options: CarouselOptions(
              height: 300,
              initialPage: 0,// الصفحه اللى هيبدء بيها هيا الاولى فى الليست رقم 1
              autoPlay: true,// هتشتغل لوحدها
              viewportFraction:1 ,//علشان الصوره تملى المساحه بتاعتها
              autoPlayInterval: Duration(seconds: 6),//الوقت اللى   محتاجه علشان يحول لصفحه غير اللى موجوده
              autoPlayAnimationDuration: Duration(seconds: 4),// الوقت لعرض الانيميشن عند التحويل بين الشاشات
              autoPlayCurve: Curves.ease,//شكل التحويل بين الشاشات
              scrollDirection: Axis.horizontal,
              reverse: false,//علشان لما احول يمين ميعكسش ويعمل شمال
              enableInfiniteScroll: true,//يفضل يلف علطول
            ),
          ),
          SizedBox(
            height:20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                SizedBox(
                  height:20.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    scrollDirection:  Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index)=> buildCategoriesItem( categoriesModels.data.data[index]),
                      separatorBuilder:(context,index)=>SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModels.data.data.length,
                  ),
                ),
                SizedBox(
                  height:20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height:20.0,
          ),
          Container(
            color: Colors.grey[400],
            child: GridView.count(
              shrinkWrap: true,//علشان يسكرول الكل مع بعض
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,//عدد العناصر اللى هتكىن فى الصف
               crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio:1/1.7,//الطول على العرض كمساحه
              children: List.generate(
                   model.data.products.length,
                       (index) => buildGridView(model.data.products[index], context),
               ),
            ),
          )

        ],
      ),
    );
  }
  Widget buildGridView(productsModel model,BuildContext context)=>Container(
    color: Colors.white,
    child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image:NetworkImage(model.image),
              fit:BoxFit.cover,
              height:180.0,
              width:double.infinity,
            ),
            if(model.discount !=0)
              Container(
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
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 14.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',//علشان يدينى رقم  integer
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 2.0,
                      color: dafultColor,
                    ),
                  ),
                  SizedBox(
                    width:10.0,
                  ),
                  if(model.discount !=0)
                   Text(
                        '${model.oldPrice.round()}',//علشان يدينى رقم  integer
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
                      shopCubit.get(context).ChgangeFavorites(model.id);

                    },
                    icon: CircleAvatar(
                      radius: 16.0,
                      backgroundColor : shopCubit.get(context).favorites[model.id]?Colors.blue:Colors.grey,
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
  );

  Widget buildCategoriesItem(DataModel model){
    return Stack(

      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
          height: 100.0,
          width: 100.0,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100.0,
          child: Text(
           model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,

            ),
          ),
        ),

      ],
    );
  }
}
