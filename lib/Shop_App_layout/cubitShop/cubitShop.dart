

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_layout/cubitShop/statesShop.dart';

import '../../Shop_App_Modules/categories/categoriesScreen.dart';
import '../../Shop_App_Modules/favorites/favoritesScreen.dart';
import '../../Shop_App_Modules/product/productsScreen.dart';
import '../../Shop_App_Modules/search/searchScreen.dart';
import '../../Shop_App_Modules/settinges/settingsScreen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shopModels/HomeModels/HomeModels.dart';
import '../../shopModels/categoritesModels/categoritesModels.dart';
import '../../shopModels/favoritesModels/changeFavoritesModels.dart';
import '../../shopModels/favoritesModels/favoritesModels.dart';
import '../../shopModels/modelsLogin/login_models.dart';

class shopCubit extends Cubit<shopStates>{
  shopCubit() : super(shopInitiState());
static shopCubit get(context)=>BlocProvider.of(context);
int curruntIndex=0;
List<Widget> bottomScreen=[
  productsScreen(),
  categoriesScreen(),
  favoritesScreen(),

  settingsScreen(),

  searchScreen(),
];
void changeBottom(int index){
  curruntIndex=index;
  emit(shopChangeBottomNavState());
}

  HomeModel homeModel;

  Map<int,bool> favorites={};
  void getHomeData(){
    emit(shopLoadingHomeDataState());
    DioHelper.getData(
      url: PRODUCTS,
      token: token,

    ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
        element.id:element.inFavorites
      });
      });


      print(favorites.toString());

      emit(shopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());


      emit(shopErrorHomeDataState());
    });
  }



  CategoriesModels categoriesModels;

  void getCategories(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModels=CategoriesModels.fromJson(value.data);


      emit(shopSuccessCategoritesState());
    }).catchError((error)
    {
      print(error.toString());


      emit(shopErrorCategoritesState());
    });
  }











   ChangeFavoritesModel changeFavoritesModel;
void ChgangeFavorites(int productID){
DioHelper.postdata(
    url: FAVORITES,
    data: {
      'product_id':productID,
    },

  token:token,
).then((value) {
  favorites[productID]!=favorites[productID];
   emit(shopChangeFavoritesState());

  changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
  if(!changeFavoritesModel.status)
    {
      favorites[productID]!=favorites[productID];//علشان لو هى false  مينورش او لما يحصل error
    }else
      {
        getFavorites();
      }
  print(value.data);
  emit(shopSuccessChangeFavoritesState(changeFavoritesModel
  ));
}).catchError((error){
  favorites[productID]!=favorites[productID];//علشان لو هى false  مينورش او لما يحصل error

  emit(shopErrorChangeFavoritesState());
});

}







  shopLoginModel loginModel;
  void getProfile(){
    emit(shopLoadingGetProfileState());
    DioHelper.getData(
      url:PROFILE,
      token: token,
    ).then((value) {
      loginModel=shopLoginModel.fromJson(value.data);
      emit(shopSuccesGetProfileState(loginModel));
    }).catchError((error){
      emit(shopErrorGetProfileState());
    }
    );

  }



  void updateProfile(
  {
    @required String name,
    @required String email,
    @required String phone,
}
      ){
    emit(shopLoadingUpdateProfileState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      loginModel=shopLoginModel.fromJson(value.data);
      emit(shopSuccesUpdateProfileState(loginModel));
    }).catchError((error){
      emit(shopErrorUpdateProfileState());
    }
    );

  }

  IconData  sufixIcon=Icons.visibility_off;
  bool isPasswordShowen=false;

void changePasswordForProfile()
{
  isPasswordShowen=!isPasswordShowen;
  isPasswordShowen? sufixIcon=Icons.visibility_off: sufixIcon=Icons.visibility;
  emit(shopChangePassword());
}


  FavoritesModel favoritesModel;

  void getFavorites(){
    emit(shopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);

      printFullText(value.data.toString());


      emit(shopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());


      emit(shopErrorGetFavoritesState());
    });
  }





}
