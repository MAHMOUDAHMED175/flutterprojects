import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/layout/news_app_layout/cubit/states.dart';

import '../../../News_App_modules/sports/sports_screen.dart';
import '../../../News_App_modules/entertainment/entertainment.dart';
import '../../../News_App_modules/policy/policy.dart';
import '../../../News_App_modules/science/science_screen.dart';
import '../../../News_App_modules/technology/technologey.dart';
import '../../../News_App_modules/business/business_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex =0;
  List<BottomNavigationBarItem> bottomItem=[
    BottomNavigationBarItem(
      icon:Icon(Icons.local_police_rounded),
      label:'Politics',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.business_outlined),
      label:'Business',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.sports),
      label:'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.science),
      label:'Science',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.business_center),
      label:'Entertainmet',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.biotech_rounded),
      label:'Technology',
    ),

  ];
  List<Widget> screen=[
    policyScreen(),
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    EntertainmentScreen(),
    TechnologyScreen(),
  ];
 void changeBottomVavBar(int index)
 {
   // if(index==1)
   //   getSports();
   // if(index==2)
   //   getScience();
   currentIndex=index;
   emit(NewsBottomNavState());

 }
  int SeclecteBusinessItem=0;

void selectedBusinessItem(index){

  SeclecteBusinessItem=index;
  //     for(int i=0;i<SeclecteBusinessItem.length;i++)
//     {
//       if(i==index)
//         {
//           SeclecteBusinessItem[i]=true;
//         }
//       else
//         SeclecteBusinessItem[i]=false;
//
//      }
   emit(NewsSelectedBusinessItemState());
 }
bool isDesktop=false;
void setDesktop(bool value){
  isDesktop=value;
  emit(NewsSetDesktopState());

}


 List<dynamic> business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'business',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',

        }
    ).then((value){
      business=value.data['articles'];
      // business.forEach((element) {
      //   SeclecteBusinessItem.add(false);
      // });









      // business.forEach((element) {
      //   businessSelectedItem.add(false);
      // });
      print(business[0]['title']);
      emit((NewsGetBusinessSuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetBusinessErrorState(error.toString())));
    });
  }



  List<dynamic> sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'sports',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',
        }
    ).then((value){
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit((NewsGetSportsSuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetSportsErrorState(error.toString())));
    });
  }



  List<dynamic> science=[];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'science',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',

        }
    ).then((value){
      science=value.data['articles'];
      print(science[0]['title']);

      emit((NewsGetScienceSuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetScienceErrorState(error.toString())));

    });
  }




  List<dynamic> policy=[];
  void getPolicy(){
    emit(NewsGetPolicyLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'politics',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',
        }
    ).then((value){
      policy=value.data['articles'];
      print(policy[0]['title']);
      emit((NewsGetPolicySuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetPolicyErrorState(error.toString())));
    });
  }

  List<dynamic> search=[];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search=[];
    DioHelper.getData(
        url:'v2/everything',
        query:{
          'q':'$value',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',
        }
    ).then((value){
      search=value.data['articles'];
      print(search[0]['title']);
      emit((NewsGetSearchSuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetSearchErrorState(error.toString())));
    });
  }

  List<dynamic> entertainment=[];
  void getEntertainment(){
    emit(NewsGetEntertainmentLoadingState());

    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'entertainment',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',
        }
    ).then((value){
      entertainment=value.data['articles'];
      emit((NewsGetEntertainmentSuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetEntertainmentErrorState(error.toString())));
    });
  }


  List<dynamic> technology=[];
  void getTechnology(){
    emit(NewsGetTechnologyLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'technology',
          'apiKey':'7d2f289e8a7742a1951724d05bef8e81',
        }
    ).then((value){
      technology=value.data['articles'];
      emit((NewsGetTechnologySuccessState()));
    }).catchError((error){
      print(error.toString());
      emit((NewsGetTechnologyErrorState(error.toString())));
    });
  }




}


