import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/category/Category_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/product/product_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/favorite_model.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() :  super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.apps,
    Icons.favorite,
    Icons.settings,
  ];

  int currentIndex = 0;
  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int? , bool?> favorites = {};
  void getHomeData(){
    emit(ShopGetHomeDataLoadingstate());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopGetHomeDataSuccessstate());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetHomeDataErrorstate());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData(){
    emit(ShopGetCategoryDataLoadingstate());
    DioHelper.getData(
      url: CATEGORY,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopGetCategoryDataSuccessstate());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetCategoryDataErrorstate());
    });
  }
  
  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteLoadingstate());
    DioHelper.postData(
      url: FAVORITE,
      data: {
        'product_id' : productId,
      },
      token: token,
    ).then((value) {
      if(changeFavoriteModel?.status == false)
        favorites[productId] = !favorites[productId]!;
      else
        getFavorite();
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
        emit(ShopChangeFavoriteSuccessstate(changeFavoriteModel!));
    }).catchError((error){
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopChangeFavoriteErrorstate());
    });
  }

  FavoriteModel? favoriteModel;
  void getFavorite(){
    emit(ShopGetFavoriteDataLoadingstate());
    DioHelper.getData(
      url: GET_FAVORITE,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopGetFavoriteDataSuccessstate());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetFavoriteDataErrorstate());
    });
  }

  LoginModel? profileModel;
  void getUserData(){
    emit(ShopGetUserDataLoadingstate());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessstate());
    }).catchError((error){
      emit(ShopGetUserDataErrorstate());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopUpdateUserDataLoadingstate());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
      token: token,
    ).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      emit(ShopUpdateUserDataSuccessstate());
    }).catchError((error){
      emit(ShopUpdateUserDataErrorstate());
    });
  }
}