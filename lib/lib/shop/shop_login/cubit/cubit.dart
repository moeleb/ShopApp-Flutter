import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopppp/lib/shared/remote/dio_helper.dart';
import 'package:shopppp/lib/shop/models/login_model.dart';
import 'package:shopppp/lib/shop/shop_login/cubit/states.dart';

import '../../endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel ;
  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel.data.token);
      // print(loginModel.status);
      // print(loginModel.message);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true ;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown? Icons.visibility_outlined:Icons.visibility_off;
    emit(ShopChangePasswordVisibilityState());

  }
}
