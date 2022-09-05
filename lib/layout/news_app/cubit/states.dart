abstract class NewsStates{}
class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}
class NewsSelectedBusinessItemState extends NewsStates{}
class NewsSetDesktopState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{
  final String error;

  NewsGetBusinessErrorState(this.error);
}
class NewsGetSportsLoadingState extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates{
  final String error;

  NewsGetSportsErrorState(this.error);
}







class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates{
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetPolicyLoadingState extends NewsStates{}
class NewsGetPolicySuccessState extends NewsStates{}
class NewsGetPolicyErrorState extends NewsStates{

  final String error;
  NewsGetPolicyErrorState(this.error);
}
class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{

  final String error;
  NewsGetSearchErrorState(this.error);
}
class NewsGetEntertainmentLoadingState extends NewsStates{}
class NewsGetEntertainmentSuccessState extends NewsStates{}
class NewsGetEntertainmentErrorState extends NewsStates{

  final String error;
  NewsGetEntertainmentErrorState(this.error);
}
class NewsGetTechnologyLoadingState extends NewsStates{}
class NewsGetTechnologySuccessState extends NewsStates{}
class NewsGetTechnologyErrorState extends NewsStates{

  final String error;
  NewsGetTechnologyErrorState(this.error);
}
