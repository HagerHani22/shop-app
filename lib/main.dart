
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/shop_app/login/cubit/cubit.dart';
import 'modules/shop_app/login/shop_login.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/shop_app/register/cubit/cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? email = CacheHelper.getUser(key: 'email') ?? false;
  bool? isDark = CacheHelper.getUser(key: 'isDark') ?? false;

  Widget widget;
  bool? onboarding = CacheHelper.getUser(key: 'onboarding') ?? false;

  token = CacheHelper.getUser(key: 'token');

  print(token);

  if(onboarding != null){
    if(token!= null){
      widget=const ShopLayout();
    }else {
      widget=ShopLoginScreen();
    }
  }else {
    widget=const OnBoardingScreen();
  }


  runApp(MyApp(
    email: email,
    isDark: isDark,
    startWidget: widget,
  ));
 }
class MyApp extends StatelessWidget {
  final bool? email;
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.email, this.isDark, this.startWidget});

  bool? onboarding = CacheHelper.getUser(key: 'onboarding') ?? false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShopLoginCubit()),
          BlocProvider(create: (context) => ShopRegisterCubit()),
          BlocProvider(
              create: (context) => ShopCubits()
                ..getHomeData()
                ..getCategories()
                ..getFavourite()
                ..getUserData()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme:darkTheme ,
          themeMode: ThemeMode.light,
          home: onboarding! ? ShopLoginScreen():const OnBoardingScreen(),
        ));
  }
}
