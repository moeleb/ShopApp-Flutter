import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopppp/lib/shared/appcubit/cubit.dart';
import 'package:shopppp/lib/shared/appcubit/states.dart';
import 'package:shopppp/lib/shared/blocObserver.dart';
import 'package:shopppp/lib/shared/cache_helper.dart';
import 'package:shopppp/lib/shared/constants.dart';
import 'package:shopppp/lib/shared/remote/dio_helper.dart';
import 'package:shopppp/lib/shared/themes/theme.dart';
import 'package:shopppp/lib/shop/cubit/cubit.dart';
import 'package:shopppp/lib/shop/on_boarding_screen.dart';
import 'package:shopppp/lib/shop/shop_layout/shop_layout.dart';
import 'package:shopppp/lib/shop/shop_login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  if(onBoarding!=null){
    if(token !=null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  const MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            //     AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
