import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/shared/components/components.dart';

import '../../layout/news_app_layout/cubit/cubit.dart';
import '../../layout/news_app_layout/cubit/states.dart';


class EntertainmentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,state){
        var  list=NewsCubit.get(context).entertainment;
        return articleBuilder(list,context);
      },
    );
  }
}
