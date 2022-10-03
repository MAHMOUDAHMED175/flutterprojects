
import '../../../shopModels/modelsLogin/login_models.dart';

abstract class shopRegisterStates{}
class shopRegisterInitiState extends shopRegisterStates{}
class shopRegisterLoadingState extends shopRegisterStates{}
class shopRegisterSuccessState extends shopRegisterStates{
  final shopLoginModel loginModel;

  shopRegisterSuccessState(this.loginModel);
}
class shopRegisterErrorState extends shopRegisterStates{
  final String Error;
  shopRegisterErrorState(this.Error);
}
class shopRegisterChangePassowrdVisibilityState extends shopRegisterStates{}