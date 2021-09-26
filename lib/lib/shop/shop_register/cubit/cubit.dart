import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopppp/lib/shared/remote/dio_helper.dart';
import 'package:shopppp/lib/shop/models/login_model.dart';
import 'package:shopppp/lib/shop/shop_register/cubit/states.dart';

import '../../endpoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel ;
  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email': email,
        'password': password,
        'phone': phone,

    },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel.data.token);
      // print(loginModel.status);
      // print(loginModel.message);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
      print(error.toString());
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true ;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown? Icons.visibility_outlined:Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());

  }

}
