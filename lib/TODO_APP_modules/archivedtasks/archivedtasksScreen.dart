import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/shared/components/components.dart';
import 'package:new_pp/shared/components/constants.dart';

import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

class archivedtasksScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){},
      builder:(context,state){
        var tasks=AppCubit.get(context).archivedTasks;

        return ConditionalBuilderTasks(tasks: tasks, text: 'No Archived Tasks',IconForScreen:Icons.archive,);
      },


    );
  }
}
