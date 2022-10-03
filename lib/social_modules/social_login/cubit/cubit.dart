

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/social_modules/social_login/cubit/states.dart';



class socialLoginCubit extends Cubit<socialLoginStates>{
  socialLoginCubit() : super(socialLoginInitiState());

  static socialLoginCubit get(context)=>BlocProvider.of(context);


  IconData sufixIcon=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword=!isPassword;
    sufixIcon=isPassword ?Icons.visibility_off:Icons.visibility;
     emit(socialChangePassowrdVisibilityState());
  }


}