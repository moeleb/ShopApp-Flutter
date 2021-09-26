import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopppp/lib/shared/constants.dart';
import 'package:shopppp/lib/shared/remote/dio_helper.dart';
import 'package:shopppp/lib/shop/cubit/states.dart';
import 'package:shopppp/lib/shop/models/categories_model.dart';
import 'package:shopppp/lib/shop/models/change_favorites_model.dart';
import 'package:shopppp/lib/shop/models/favorites_model.dart';
import 'package:shopppp/lib/shop/models/homeModel.dart';
import 'package:shopppp/lib/shop/models/login_model.dart';
import 'package:shopppp/lib/shop/screens/categories_screen.dart';
import 'package:shopppp/lib/shop/screens/cubit/settings_Screen.dart';
import 'package:shopppp/lib/shop/screens/favorites_screen.dart';
import 'package:shopppp/lib/shop/screens/products_screen.dart';
import '../endpoints.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ShopProductScreen(),
    ShopCategoriesScreen(),
    ShopFavoriteScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data.banners[0].image);
      print(homeModel.status);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessDataState());
    }).catchError((error) {
      print('${error.toString()}');
      emit(ShopErrorDataState(error));
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print('${error.toString()}');
      emit(ShopErrorCategoriesDataState(error));
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, token: token, data: {
      'product_id': productId,
    }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopSuccessGetFavoritesLoadingDataState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print('${error.toString()}');
      emit(ShopErrorGetFavoritesDataState(error));
    });
  }


  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.toString());
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print('${error.toString()}');
      emit(ShopErrorLoadingUserDataState(error));
    });
  }

  void updateUserData({
  @required String name ,
  @required String email ,
  @required String phone ,
}) {
    emit(ShopLoadingUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.toString());
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print('${error.toString()}');
      emit(ShopErrorLoadingUserDataState(error));
    });
  }

}
