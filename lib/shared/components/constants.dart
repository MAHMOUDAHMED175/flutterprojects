
import '../../Shop_App_Modules/shop_login/login.dart';
import '../network/local/cache_helper/cacheHelper.dart';
import 'components.dart';

void sinOut(context){
  CacheHelper.sharedPreferences.remove('token').then((value){
    if(value) {
      navigateAndFinish(context, shopLogin());
    }
  });
}

//ميثود علشان تعرض النص كامل
void printFullText(String text){
  final pattern =RegExp('{1,800}');//800 is the size of each chunk
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}
String token='';