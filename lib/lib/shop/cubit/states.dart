
import 'package:shopppp/lib/shop/models/change_favorites_model.dart';
import 'package:shopppp/lib/shop/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessDataState extends ShopStates{}

class ShopErrorDataState extends ShopStates
{
  final String error ;

  ShopErrorDataState(this.error);

}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates
{
  final String error ;

  ShopErrorCategoriesDataState(this.error);

}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model ;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates
{
  final String error ;

  ShopErrorChangeFavoritesState(this.error);

}

class ShopSuccessGetFavoritesLoadingDataState extends ShopStates{}


class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates
{
  final String error ;

  ShopErrorGetFavoritesDataState(this.error);

}

class ShopLoadingUserDataState extends ShopStates{}


class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorLoadingUserDataState extends ShopStates
{
  final String error ;

  ShopErrorLoadingUserDataState(this.error);

}

class ShopLoadingUpdateUserState extends ShopStates{}


class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorLoadingUpdateUserState extends ShopStates
{
  final String error ;

  ShopErrorLoadingUpdateUserState(this.error);

}


