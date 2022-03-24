import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app6/modules/home_layout.dart';
import 'package:flutter_app6/modules/login_screen.dart';
import 'package:flutter_app6/modules/onboarding_screen.dart';
import 'package:flutter_app6/shared/network/local/cache_helper.dart';
import 'package:flutter_app6/shared/network/remote/dio_helper.dart';
import 'package:flutter_app6/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();

  bool isBoarding = await CacheHelper.getshared(key: 'isBoarding');
  bool isLogin = await CacheHelper.getshared(key: 'isLogin');

  Widget widget;
  if(isBoarding.toString() != 'null'){
    if(isLogin.toString() != 'null'){
      widget = HomeLayout();
    }else{
      widget = LoginScreen();
    }
  }else{
    widget = OnBoiardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  Widget widget;
  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      //darkTheme: ,
      //themeMode: ,
      home: widget,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}