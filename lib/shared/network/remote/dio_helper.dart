import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio dio;
  static init(){
    dio=Dio(
      BaseOptions(
      baseUrl:'https://newsapi.org/' ,
       receiveDataWhenStatusError: true,//علشان يجيب الداتا فى اى طريقه حتى لو غلط وملكش دعوه بحاله ال state
      )
    );
  }
  static Future<Response> getData({
    @required String url,
    @required Map<String,dynamic> query,

  })async{
    return await dio.get(
        url,
        queryParameters: query,
    );
  }
}