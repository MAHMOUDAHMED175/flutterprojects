import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/search/searchStates.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shopModels/searchModels/searchModel.dart';

class searchCupit extends Cubit<searchStates>{
  searchCupit() : super(searchInitiState());

  static searchCupit get(context)=>BlocProvider.of(context);


  SearchModel model;

  void search(String text){
    emit(searchLoadingState());
    DioHelper.postdata(
      url:SEARCH,
      token:token,
      data:{
        'text':text,
      },
    ).then((value)
    {
      model=SearchModel.fromJson(value.data);
      emit(searchSuccessState());
    }).catchError((error)
    {
      print(error.toString());


      emit(searchErrorState());
    });
  }


}