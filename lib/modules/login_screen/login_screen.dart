import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/login_cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/login_states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';

import '../../shared/components/constants.dart';
import '../../shared/style/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
            if(state.loginModel.status == true) {
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token).then((
                  value) {
                    token = state.loginModel.data!.token!;
                showToast(text: state.loginModel.message!,
                    state: ToastStates.SUCCESS);
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              showToast(text: state.loginModel.message!, state: ToastStates.ERROR);
            }


        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: height*0.1,),
                    Container(
                      height: height * .22,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/salla.jpg'),
                            height: 150,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Text(
                              'Salla',
                              style: TextStyle(
                                  fontFamily: 'Pacifico', fontSize: 23),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .1,
                    ),
                    defaultFormField(
                      controller: emailController,
                      text: 'Email',
                      prefix: Icons.email_outlined,
                      validate: (value) {
                        if (value!.isEmpty) return 'email must not be empty';
                        return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      text: 'Password',
                      prefix: Icons.lock_outline,
                      isPassword: LoginCubit.get(context).isVisiable,
                      validate: (value) {
                        if (value!.isEmpty) return 'password must not be empty';
                        return null;
                      },
                      type: TextInputType.visiblePassword,
                      suffixPressed: () {
                        LoginCubit.get(context).changeVisiable();
                      },
                      suffix: LoginCubit.get(context).suffix,
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (context) => defaultTextButtom(
                        text: 'LOGIN',
                        onPressed: () {
                          if (formKey.currentState!.validate())
                            LoginCubit.get(context).userData(
                                email: emailController.text,
                                password: passwordController.text);
                        },
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
                    ),
                    SizedBox(
                      height: height * .001,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            navigaiteTo(context, RegisterScreen());
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
