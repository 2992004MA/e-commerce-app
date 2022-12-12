import 'package:shop_app/models/change_favorites.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopGetHomeDataLoadingstate extends ShopStates{}

class ShopGetHomeDataSuccessstate extends ShopStates{}

class ShopGetHomeDataErrorstate extends ShopStates{}

class ShopGetCategoryDataLoadingstate extends ShopStates{}

class ShopGetCategoryDataSuccessstate extends ShopStates{}

class ShopGetCategoryDataErrorstate extends ShopStates{}

class ShopChangeFavoriteLoadingstate extends ShopStates{}

class ShopChangeFavoriteSuccessstate extends ShopStates{
  final ChangeFavoriteModel model;

  ShopChangeFavoriteSuccessstate(this.model);
}

class ShopChangeFavoriteErrorstate extends ShopStates{}

class ShopGetFavoriteDataLoadingstate extends ShopStates{}

class ShopGetFavoriteDataSuccessstate extends ShopStates{}

class ShopGetFavoriteDataErrorstate extends ShopStates{}

class ShopGetUserDataLoadingstate extends ShopStates{}

class ShopGetUserDataSuccessstate extends ShopStates{}

class ShopGetUserDataErrorstate extends ShopStates{}

class ShopUpdateUserDataLoadingstate extends ShopStates{}

class ShopUpdateUserDataSuccessstate extends ShopStates{}

class ShopUpdateUserDataErrorstate extends ShopStates{}