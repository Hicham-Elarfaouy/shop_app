import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app6/models/categories_model.dart';
import 'package:flutter_app6/models/favorites_model.dart';
import 'package:flutter_app6/models/home_model.dart';
import 'package:flutter_app6/models/search_model.dart';
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
  
  UserData? profileData;
  
  void getProfileData(){
    DioHelper.getData(url: PROFILE).then((value) {
      print(value.data);
      print(value.data['message']);
      profileData = UserData.Json(value.data['data']);
      emit(stateGetProfile());
    }).catchError((error) {
      print(error.toString());
      emit(stateGetProfileError());
    });
  }

  UserModel? passwordModel;

  void postChangePassword({
    required String oldPass,
    required String newPass,
}){
    emit(stateChangePassLoading());
    DioHelper.postData(url: PASSWORD, data: {
      'current_password' : oldPass,
      'new_password' : newPass,
    }).then((value) {
      passwordModel = UserModel.Json(value.data);
      emit(stateChangePassSuccess(passwordModel));
    }).catchError((error) {
      print(error.toString());
      emit(stateChangePassError());
    });
  }

  UserModel? editProfileModel;

  void putEditProfile({
    required String name,
    required String email,
    required String phone,
}){
    emit(stateEditProfileLoading());
    DioHelper.putData(url: UPDATE_PROFILE, data: {
      "name": name,
      "phone": phone,
      "email": email,
    }).then((value) {
      editProfileModel = UserModel.Json(value.data);
      getProfileData();
      emit(stateEditProfileSuccess(editProfileModel));
    }).catchError((error) {
      print(error.toString());
      emit(stateEditProfileError());
    });
  }


  SearchModel? searchModel;

  void getSearchData({
    required String search,
}){
    emit(stateSearchLoading());
    DioHelper.postData(url: SEARCH,lang: 'en', data: {
      'text' : search,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(stateSearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(stateSearchError());
    });
  }

}