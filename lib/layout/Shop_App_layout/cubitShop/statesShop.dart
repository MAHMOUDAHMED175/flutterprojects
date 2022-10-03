import 'package:new_pp/shopModels/favoritesModels/changeFavoritesModels.dart';
import 'package:new_pp/shopModels/modelsLogin/login_models.dart';

abstract class shopStates{}
class shopInitiState extends shopStates{}

class shopChangeBottomNavState extends shopStates{}
class shopLoadingHomeDataState extends shopStates{}
class shopSuccessHomeDataState extends shopStates{}
class shopErrorHomeDataState extends shopStates{}
class shopSuccessCategoritesState extends shopStates{}
class shopErrorCategoritesState extends shopStates{}
class shopSuccessChangeFavoritesState extends shopStates{
  final ChangeFavoritesModel model;

  shopSuccessChangeFavoritesState(this.model);
}
class shopChangeFavoritesState extends shopStates{}

class shopErrorChangeFavoritesState extends shopStates{}




class shopLoadingGetFavoritesState extends shopStates{}

class shopSuccessGetFavoritesState extends shopStates{}
class shopErrorGetFavoritesState extends shopStates{}


class shopLoadingGetProfileState extends shopStates{

}

class shopSuccesGetProfileState extends shopStates{

  final shopLoginModel loginModel;

  shopSuccesGetProfileState(this.loginModel);

}

class shopErrorGetProfileState extends shopStates{}



class shopLoadingUpdateProfileState extends shopStates{

}

class shopSuccesUpdateProfileState extends shopStates{

  final shopLoginModel loginModel;

  shopSuccesUpdateProfileState(this.loginModel);

}

class shopErrorUpdateProfileState extends shopStates{}
class shopChangePassword extends shopStates{}


// abstract class searchStates{}
class searchInitiState extends shopStates{}
class searchLoadingState extends shopStates{}
class searchSuccessState extends shopStates{}
class searchErrorState extends shopStates{}
