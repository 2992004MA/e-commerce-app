import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register_screen/cubit/register_states.dart';
import 'package:shop_app/shared/components/component.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/style/colors.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
            if(state.RegisterModel.status == true) {
              CacheHelper.saveData(
                  key: 'token', value: state.RegisterModel.data!.token).then((
                  value) {
                token = state.RegisterModel.data!.token!;
                showToast(text: state.RegisterModel.message!,
                    state: ToastStates.SUCCESS);
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              showToast(text: state.RegisterModel.message!, state: ToastStates.ERROR);
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.16,
                        ),
                        Text(
                          'Create An Account',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        defaultFormField(
                          controller: nameController,
                          text: 'Name',
                          prefix: Icons.person_outline_rounded,
                          validate: (value) {
                            if (value!.isEmpty) return 'name must not be empty';
                            return null;
                          },
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        defaultFormField(
                          controller: emailController,
                          text: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) return 'email must not be empty';
                            return null;
                          },
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          text: 'Password',
                          prefix: Icons.lock_outline,
                          isPassword: RegisterCubit.get(context).isVisiable,
                          validate: (value) {
                            if (value!.isEmpty)
                              return 'password must not be empty';
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                          suffixPressed: () {
                            RegisterCubit.get(context).changeVisiable();
                          },
                          suffix: RegisterCubit.get(context).suffix,
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          text: 'Phone',
                          prefix: Icons.phone_outlined,
                          validate: (value) {
                            if (value!.isEmpty) return 'phone must not be empty';
                            return null;
                          },
                          type: TextInputType.phone,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultTextButtom(
                            text: 'Sign Up',
                            onPressed: () {
                              if(formKey.currentState!.validate())
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                            },
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: defaultColor,
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
