import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio dio;
  static init(){
    dio=Dio(
      BaseOptions(
        //baseUrl:'https://newsapi.org/',//دى بتاعت ال news
        baseUrl: 'https://student.valuxapps.com/api/',
     //  ,دى بتاعت ال shop
       receiveDataWhenStatusError: true,//علشان يجيب الداتا فى اى طريقه حتى لو غلط وملكش دعوه بحاله ال state
      // headers: {
      //   'Content-Type':'application/json',
      // },
      )
    );
  }
  // هيستقبل داتا
  static Future<Response> getData({
    @required String url,
    Map<String,dynamic> query,
    String lang='en',
    String token,
  })async{
    dio.options.headers= {
      'lang':lang,
      //دا التوكين كل واحد ليه توكين خاص بيه لما بيعمل تسجيل دخول
      'Authorization':'67m6XjqBYy17CzpDWQCcXc5FvkuBqZJhNTCnyPeE0sQ5xbQyd5azCD7lod9kh1SJv16kew',
      'Content-Type':'application/json',

    };
    return await dio.get(
        url,
        queryParameters: query,
    );
  }
//هيبعت داتا
  static Future<Response> postdata(
      {
        @required String url,
        Map<String,dynamic> query,
        @required Map<String,dynamic> data,
        String lang='en',
        String token,
      })async{
    dio.options.headers= {
      'lang':lang,
      'Authorization':'67m6XjqBYy17CzpDWQCcXc5FvkuBqZJhNTCnyPeE0sQ5xbQyd5azCD7lod9kh1SJv16kew',
      'Content-Type':'application/json',

    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );


  }





//هيحط داتا مكان داتا ويستبدلها update
  static Future<Response> putData(
      {
        @required String url,
        Map<String,dynamic> query,
        @required Map<String,dynamic> data,
        String lang='en',
        String token,
      })async{
    dio.options.headers= {
      'lang':lang,
      'Authorization':'67m6XjqBYy17CzpDWQCcXc5FvkuBqZJhNTCnyPeE0sQ5xbQyd5azCD7lod9kh1SJv16kew',
      'Content-Type':'application/json',

    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );


  }
}