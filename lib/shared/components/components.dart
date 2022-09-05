

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:new_pp/layout/news_app/cubit/cubit.dart';
import 'package:new_pp/modules/web_view/web_view_screen.dart';

import '../Cubit/cubit.dart';

Widget defaultButton({
  double width=double .infinity,
  Color background=Colors.deepOrangeAccent,
  bool isUpperCase=true,
  double radius,
  Function() send,
  String text,
})=>Container(
  width: width,
  child: MaterialButton(
    onPressed: send,
    child: Text(
      isUpperCase?text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
      color: background,
      borderRadius:BorderRadius.circular(6.9)
  ),
);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function(String) validate,
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
  child:   InkWell(

    onTap: (){

      NewsCubit.get(context).selectedBusinessItem(index);
      navigatorTo(context, WebViewScreen(article['url']['url']));

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
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start:20.3,
  ),
  child: Container(
    color: Colors.grey,
    height:1.0,
  ),
);
Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
    physics:BouncingScrollPhysics(),//علشان يحوش اللون الازرق لتفوق وميكنش فيه عناصر تانى وتكون الليست انتهت  فلما اشد ميظهرش لون ازرق
    itemBuilder: (context ,index)=>buildArticleItem(list[index],context,index),
    separatorBuilder: (context , index)=>myDivider(),
    itemCount:list.length,
  ),
  fallback: (context)=>isSearch==true?Container():Center(child: CircularProgressIndicator()),
);


void navigatorTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget
)
);