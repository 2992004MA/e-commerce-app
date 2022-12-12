import '../../../models/login_model.dart';

abstract class LoginStates{}

class ShopLoginInitialState extends LoginStates{}

class ShopLoginLoadingState extends LoginStates{}

class ShopLoginSuccessState extends LoginStates{
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends LoginStates{}

class ShopChangeVisiable extends LoginStates{}
