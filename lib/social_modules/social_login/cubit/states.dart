abstract class socialLoginStates{}
class socialLoginInitiState extends socialLoginStates{}
class socialLoginLoadingState extends socialLoginStates{}
class socialLoginSuccessState extends socialLoginStates{}
class socialLoginErrorState extends socialLoginStates{
  final String Error;
  socialLoginErrorState(this.Error);
}
class socialChangePassowrdVisibilityState extends socialLoginStates{}