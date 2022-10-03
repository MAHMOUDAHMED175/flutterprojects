

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_pp/layout/Shop_App_layout/cubitShop/cubitShop.dart';

import '../../News_App_modules/web_view/web_view_screen.dart';
import '../../TODO_APP_modules/Cubit/cubit.dart';
import '../../layout/news_app_layout/cubit/cubit.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width=double .infinity,
  Color background=Colors.blueAccent,
  bool isUpperCase=true,
  double radius,

  Function() send,
  Function() onclick,

  String text,
})=>Container(

  width: width,
  child: MaterialButton(

    onPressed: onclick,
    child: Text(
      isUpperCase?text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
      color: background,
      borderRadius:BorderRadius.circular(55.9)
  ),
);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function(String) validate,
  Function(String) onSubmit,
  Function(String) onChange,
  @required String label,
  Function() suffixIconn,
  Function() suffixPressed,
  Function() onTap,
  @required IconData prefix,
  IconData suffix,

  bool isPassword=false,
})=>TextFormField(
  controller:controller,
  keyboardType:type,
  onTap:onTap,

  onChanged: onChange,
  onFieldSubmitted: onSubmit,
  validator: validate,
  obscureText:isPassword ,
  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon:suffix !=null ? IconButton(
      onPressed:suffixPressed,
      icon: Icon(
        suffix,
      ),
    ):null,
    border: const OutlineInputBorder(),
  ),
);
// Widget buildTaskItem(Map model)=> Padding(
//   padding:  EdgeInsets.all(20.0),
//   child: Row(
//     mainAxisSize: MainAxisSize.min,
//     children:[
//       CircleAvatar(
//         radius:40.2,
//         child: Text(
//           "${model['time']}",
//         ),
//       ),
//       SizedBox(
//         width: 20.0,
//       ),
//       Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children:[
//           Text(
//             "${model['title']}",
//             style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "${model['date']}",
//             style: TextStyle(
//               color:Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// );
//Dismissible دى بتخليك تعمل swap وتحريك من اليمين للشمال علشان تحذف العنصر
Widget buildTaskItem(Map model,context)=>Dismissible(
  key:Key(model['id'].toString()),
  onDismissed:(directions){
    AppCubit.get(context).Deletedata(model['id']);
  },
  child:Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        CircleAvatar(

          radius: 40.5,

          child: Text("${model['time']}"),

        ),
        SizedBox(

          width:12.5,

        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            //crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("${model['title']}",
                  maxLines: 2,
                  textWidthBasis: TextWidthBasis.longestLine,
                  style:TextStyle(
                    fontSize: 18.0,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  )
              ),
              Text("${model['date']}",

                  style:TextStyle(

                    color: Colors.grey,

                  )

              ),

            ],

          ),
        ),
        SizedBox(

          width:5.5,

        ),
        IconButton(

                onPressed:(){

                AppCubit.get(context).Updatedata('done',model['id']);

                },

                icon:Icon(Icons.check_box,
size: 20.0,
                color:Colors.green,

                ),

              ),
        SizedBox(

          width:3.0,

        ),
        IconButton(

                onPressed:(){

                  AppCubit.get(context).Updatedata('archived',model['id']);

                },

                icon:Icon(
                  Icons.archive_sharp,

                size: 20,
                color: Colors.black.withOpacity(0.8),),

              ),
      ],

    ),

  ),
);
Widget ConditionalBuilderTasks({
  @required List<Map>tasks,
  @required String text,
  @required IconData IconForScreen,
})=>ConditionalBuilder(
  condition:tasks.length<=0 ,
  builder:(context)=> Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Icon(
          IconForScreen,
          size:50.0,
          color: Colors.black.withOpacity(0.3),),
        Text(text,
          style:TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.2),
          ),)
      ],
    ),
  ),
  fallback: (context)=>ListView.separated(
    itemBuilder: (context , index)=>buildTaskItem(tasks[index],context),
    separatorBuilder: (context , index)=>Padding(
      padding: const EdgeInsetsDirectional.only(
        start:20.3,
      ),
    ),
    itemCount:tasks.length,
  ),
);













//components of news App
Widget buildArticleItem(article,context,index)=>Container(
  color: NewsCubit.get(context).SeclecteBusinessItem==index&&NewsCubit.get(context).isDesktop?Colors.grey[300]:null,
  child:   InkWell//علشان يخلى مجموعه عناصر مع بعض يتداس عليهم كأنهم عنصر واحد
    (

    onTap: (){

      NewsCubit.get(context).selectedBusinessItem(index);
      navigatorTo(context, WebViewScreen(article['url']));

    },

    child:   Padding(



      padding: const EdgeInsets.all(8.0),



      child: Row(



        children: [



          Container(



            width:120.0,



            height:120.0,



            decoration: BoxDecoration(



                borderRadius: BorderRadius.circular(28.0,),



                image: DecorationImage(



                    image: NetworkImage('${article['urlToImage']}'),



                    fit: BoxFit.cover



                )



            ),



          ),



          SizedBox(



            width:20.0 ,



          ),



          Expanded(



            child: Container(



              height:120.0,



              child: Column(



                mainAxisAlignment: MainAxisAlignment.start,



                crossAxisAlignment: CrossAxisAlignment.start,



                children: [



                  Expanded(



                    child: Text('${article['title']}',



                      maxLines: 3,



                      overflow: TextOverflow.ellipsis,



                      style:Theme.of(context).textTheme.bodyText1,



                    ),



                  ),



                  Text(



                    '${article['publishedAt']}',



                    style:TextStyle(



                      color: Colors.grey,







                    ),



                  ),



                ],



              ),



            ),



          )



        ],



      ),



    ),

  ),
);
Widget MyDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start:21.3,
  ),
  child: Container(
    color: Colors.grey,
    height:1.0,
  ),
);
Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0,//djksvdjcvjkdffvc
  //sdcsdcsdc
  builder: (context)=>ListView.separated(
    physics:BouncingScrollPhysics(),//علشان يحوش اللون الازرق لتفوق وميكنش فيه عناصر تانى وتكون الليست انتهت  فلما اشد ميظهرش لون ازرق
    itemBuilder: (context ,index)=>buildArticleItem(list[index],context,index),
    separatorBuilder: (context , index)=>MyDivider(),
    itemCount:list.length,
  ),
  fallback: (context)=>isSearch==true?Container():Center(child: CircularProgressIndicator()),
);

//دى بتعمل push وكل مره ينفع ترجع
void navigatorTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget
)
);
//دى بتعمل push ومينفعش ترجع تانى
void navigateAndFinish(context ,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder:(context)=> widget
    ),
        (route) => false
);
void showToast({
  @required String text,
  @required ToastStates state,
}){

Fluttertoast.showToast(
msg:text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.SNACKBAR,
timeInSecForIosWeb: 4,
backgroundColor: chooseColorsToast(state),
textColor: Colors.white,
fontSize: 20.2
);


}
//دى حاجه لما اكون عايز اختار مابين اكثر من 3
enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseColorsToast(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
    color=Colors.green;
    break;
    case ToastStates.ERROR:
    color=Colors.red;
    break;
    case ToastStates.WARNING:
    color=Colors.yellow;
    break;
  }
  return color;
}

Widget BuildListProduct(model, context,{bool isOldPrise=false}){

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
              Image(image:NetworkImage(model.image),
                // fit:BoxFit.cover,
                height:150.0,
                width:150.0,
              ),
              if(model.discount !=0&&isOldPrise)
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
                  model.name,
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
                      '${model.price.round()}',
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
                    if(model.discount!=0&& isOldPrise)
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
                        backgroundColor :shopCubit.get(context).favorites[model.id]?Colors.blue:Colors.grey,
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
