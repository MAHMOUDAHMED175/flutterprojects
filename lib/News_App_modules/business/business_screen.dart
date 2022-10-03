import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/layout/news_app_layout/cubit/states.dart';
import 'package:new_pp/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../layout/news_app_layout/cubit/cubit.dart';

class BusinessScreen extends StatelessWidget {

  @override


  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,state){
        var  list=NewsCubit.get(context).business;
        return ScreenTypeLayout(

            mobile:Builder(
                builder:(context){
                  NewsCubit.get(context).setDesktop(false);
                  return  articleBuilder(list,context);
                }
            ),
          desktop: Builder(
            builder:(context){
              NewsCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child:articleBuilder(list,context),),

                  if(list.length>0)
                    Expanded(
                      child:Container(
                        color: Colors.grey[300],
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '${list[NewsCubit.get(context).SeclecteBusinessItem]['description']}',
                            style: TextStyle(
                              fontSize: 28.5,
                            ),
                          ),


                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(desktop:600, tablet: 400, watch: 150.2),



        );
      },
    );
  }
}
