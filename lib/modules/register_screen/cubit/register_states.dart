import '../../../models/login_model.dart';

abstract class RegisterStates{}

class ShopRegisterInitialState extends RegisterStates{}

class ShopRegisterLoadingState extends RegisterStates{}

class ShopRegisterSuccessState extends RegisterStates{
  final LoginModel RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);
}

class ShopRegisterErrorState extends RegisterStates{}

class ShopChangeVisiable extends RegisterStates{}
