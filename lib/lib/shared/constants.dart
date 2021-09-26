
//   https://www.postman.com/collections/94db931dc503afd508a5



import 'package:shopppp/lib/shop/shop_login/login_screen.dart';

import 'cache_helper.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) navigateAndFinish(context, ShopLoginScreen());
  });
}
String token ="";