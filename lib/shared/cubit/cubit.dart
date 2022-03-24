import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app6/models/home_model.dart';
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

  static appCubit get(context) => BlocProvider.of(context);

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
      if(value.data['data'] != null){
        userData = UserData.Json(value.data['data']);
      }
      emit(stateLoginSuccess(userModel,userData));
    }).catchError((error){
      print(error.toString());
      emit(stateLoginError(error.toString()));
    });
  }

  HomeModel? homeModel;

  void getHomeData(){

    DioHelper.getData(url: HOME,lang: 'en').then((value) {

      homeModel = HomeModel.Json(value.data);
      print(homeModel?.status);
      print(homeModel?.data.banners[0].image);
      emit(stateHomeSuccess());

    }).catchError((error){

      print(error.toString());
      emit(stateHomeError());

    });
  }
}