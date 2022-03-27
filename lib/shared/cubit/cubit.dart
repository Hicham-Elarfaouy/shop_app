import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app6/models/categories_model.dart';
import 'package:flutter_app6/models/favorites_model.dart';
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

  CategoriesModel? categoriesModel;

  void getCategoriesData(){
    DioHelper.getData(url: CATEGORIES,lang: 'en').then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(stateCategoriesSuccess());

    }).catchError((error) {

      print(error.toString());
      emit(stateCategoriesError());

    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData(){

    DioHelper.getData(url: FAVORITES,lang: 'en').then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.status);

      emit(stateFavoritesSuccess());

      if(favoritesModel!.data.data.isNotEmpty){
        list.clear();
        listFav.clear();
        listFav = favoritesModel!.data.data;
        favoritesModel!.data.data.forEach((element) {
          list.add(element.product!.id);
        });
      }

      print(favoritesModel!.data.data[0].product!.id);

    }).catchError((error) {

      print(error.toString());
      emit(stateFavoritesError());

    });
  }

  List<int?> list = [];
  List<DataProducts> listFav = [];

  void postFavoriteProduct({
    required int? IdProduct,
    bool fromFav = false,
    int? index,
}){

    if(list.contains(IdProduct)){
      list.remove(IdProduct);
      if(fromFav){
        listFav.removeAt(index!);
      }
    }else{
      list.add(IdProduct);
    }
    emit(stateChangeFavorites());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : IdProduct,
        }
    ).then((value) {

      emit(stateChangeFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(stateHomeError());
    });
  }
}