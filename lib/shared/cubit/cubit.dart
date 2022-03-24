import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app6/models/user_model.dart';
import 'package:flutter_app6/modules/bottom_nav_modules/categories_screen.dart';
import 'package:flutter_app6/modules/bottom_nav_modules/favorites_screen.dart';
import 'package:flutter_app6/modules/bottom_nav_modules/home_screen.dart';
import 'package:flutter_app6/modules/bottom_nav_modules/settings_screen.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_app6/shared/network/end_points.dart';
import 'package:flutter_app6/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class appCubit extends Cubit<appStates>{
  appCubit() : super(stateInitiale());

  int currentIndex = 0;
  List<Widget> ListBottomNavWidget = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomNav(index){
    currentIndex = index;
    emit(stateChangeBottomNav());
  }

  UserModel? userModel;
  UserData? userData;
  static appCubit get(context) => BlocProvider.of(context);

  void checkUserLogin({
    required String email,
    required String password,
}){
    emit(stateLoginLoading());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      },
    ).then((value) {
      print(value.data);
      userModel = UserModel.Json(value.data);
      emit(stateLoginSuccess(userModel));

    }).catchError((error){
      print(error.toString());
      emit(stateLoginError(error.toString()));
    });
  }
}