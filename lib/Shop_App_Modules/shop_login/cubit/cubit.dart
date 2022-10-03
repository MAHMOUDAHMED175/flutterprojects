import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/shop_login/cubit/states.dart';
import 'package:new_pp/shared/network/end_points.dart';
import 'package:new_pp/shared/network/remote/dio_helper.dart';

import '../../../shopModels/modelsLogin/login_models.dart';



class shopLoginCubit extends Cubit<shopLoginStates>{
  shopLoginCubit() : super(shopLoginInitiState());

  static shopLoginCubit get(context)=>BlocProvider.of(context);

  shopLoginModel loginModel;
void userLogin({
  @required String email,
  @required String password,
})
{
  emit(shopLoginLoadingState());
DioHelper.postdata(
    url: LOGIN,
    data: {
      'email':email,
      'password':password,
    },
).then((value) {
  print(value.data);
  loginModel = shopLoginModel.fromJson(value.data);
  emit(shopLoginSuccessState(loginModel));
}).catchError((error){
  emit(shopLoginErrorState(error.toString()));
});
}

  IconData sufixIcon=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword=!isPassword;
    sufixIcon=isPassword ?Icons.visibility_off:Icons.visibility;
     emit(shopChangePassowrdVisibilityState());
  }


}