abstract class socialRegisterStates{}
class socialRegisterInitiState extends socialRegisterStates{}
class socialRegisterLoadingState extends socialRegisterStates{}
class socialRegisterSuccessState extends socialRegisterStates{}
class socialRegisterErrorState extends socialRegisterStates{
  final String Error;
  socialRegisterErrorState(this.Error);
}
class socialChangePassowrdVisibilityState extends socialRegisterStates{}