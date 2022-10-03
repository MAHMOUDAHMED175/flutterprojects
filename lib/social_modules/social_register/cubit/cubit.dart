import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/social_modules/social_register/cubit/states.dart';


class socialRegisterCubit extends Cubit<socialRegisterStates>{
  socialRegisterCubit() : super(socialRegisterInitiState());

  static socialRegisterCubit get(context)=>BlocProvider.of(context);

  Future userRegister ({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
})
  async{
    emit(socialRegisterLoadingState());
    //علشان اعمل object منfirebase  هعمل كدا زى اللى تحت دا
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:email,
        password: password
    ).then((value) {
      print('hello');
      print(value.user.email);
      print(value.user.uid);
      emit(socialRegisterSuccessState());
    }).catchError((error){
      emit(socialRegisterErrorState(error.toString()));
    });
  }
  IconData sufixIcon=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword=!isPassword;
    sufixIcon=isPassword ?Icons.visibility_off:Icons.visibility;
     emit(socialChangePassowrdVisibilityState());
  }


}