
import '../../../shopModels/modelsLogin/login_models.dart';

abstract class shopLoginStates{}
class shopLoginInitiState extends shopLoginStates{}
class shopLoginLoadingState extends shopLoginStates{}
class shopLoginSuccessState extends shopLoginStates{
  final shopLoginModel loginModel;

  shopLoginSuccessState(this.loginModel);
}
class shopLoginErrorState extends shopLoginStates{
  final String Error;
  shopLoginErrorState(this.Error);
}
class shopChangePassowrdVisibilityState extends shopLoginStates{}