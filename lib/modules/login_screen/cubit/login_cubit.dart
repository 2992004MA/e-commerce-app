import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_point.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(ShopLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;


  IconData suffix = Icons.visibility_outlined;
  bool isVisiable = true;
  void changeVisiable(){
    isVisiable = !isVisiable;
    suffix = isVisiable ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeVisiable());
  }

  void userData({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        },
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }
}