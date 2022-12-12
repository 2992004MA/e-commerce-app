import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_point.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? RegisterModel;


  IconData suffix = Icons.visibility_outlined;
  bool isVisiable = true;
  void changeVisiable(){
    isVisiable = !isVisiable;
    suffix = isVisiable ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeVisiable());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value) {
      RegisterModel = LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }
}