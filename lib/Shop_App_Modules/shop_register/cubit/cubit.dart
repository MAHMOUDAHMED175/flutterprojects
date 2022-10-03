

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/shop_register/cubit/states.dart';

import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shopModels/modelsLogin/login_models.dart';

class shopRegisterCubit extends Cubit<shopRegisterStates>{
  shopRegisterCubit() : super(shopRegisterInitiState());

  static shopRegisterCubit get(context)=>BlocProvider.of(context);

  shopLoginModel loginModel;
  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  })
  {
    emit(shopRegisterLoadingState());
    DioHelper.postdata(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,

      },
    ).then((value) {
      print(value.data);
      loginModel = shopLoginModel.fromJson(value.data);
      emit(shopRegisterSuccessState(loginModel));
    }).catchError((error){
      emit(shopRegisterErrorState(error.toString()));
    });
  }

  IconData sufixIcon=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword=!isPassword;
    sufixIcon=isPassword ?Icons.visibility_off:Icons.visibility;
    emit(shopRegisterChangePassowrdVisibilityState());
  }


}