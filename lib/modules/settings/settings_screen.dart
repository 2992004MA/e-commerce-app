import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';
import 'package:shop_app/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).profileModel;
        emailController.text = cubit!.data!.email!;
        nameController.text = cubit.data!.name!;
        phoneController.text = cubit.data!.phone!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (state is ShopUpdateUserDataLoadingstate)
                LinearProgressIndicator(
                  color: defaultColor,
                  backgroundColor: defaultColor.withOpacity(.5),
                ),
              if (state is ShopUpdateUserDataLoadingstate)
                SizedBox(
                  height: height * 0.03,
                ),
              defaultFormField(
                  controller: nameController,
                  text: 'Name',
                  prefix: Icons.person_outline_rounded,
                  validate: (value) {
                    if (value!.isEmpty) return 'name must not be empty';
                    return null;
                  },
                  type: TextInputType.name),
              SizedBox(
                height: height * 0.02,
              ),
              defaultFormField(
                  controller: emailController,
                  text: 'Email Address',
                  prefix: Icons.email_outlined,
                  validate: (value) {
                    if (value!.isEmpty) return 'email must not be empty';
                    return null;
                  },
                  type: TextInputType.emailAddress),
              SizedBox(
                height: height * 0.02,
              ),
              defaultFormField(
                  controller: phoneController,
                  text: 'Phone',
                  prefix: Icons.phone_outlined,
                  validate: (value) {
                    if (value!.isEmpty) return 'phone must not be empty';
                    return null;
                  },
                  type: TextInputType.phone),
              SizedBox(
                height: height * 0.03,
              ),
              defaultTextBottom2(
                onPressed: (){
                  ShopCubit.get(context).updateUserData(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                },
                text: 'UPDATE',
                titleIcon: Icons.update,
              ),
              SizedBox(height: height * 0.03),
              defaultTextBottom2(
                onPressed: (){
                  CacheHelper.removeData(key: 'token').then((value) {
                    if(value)
                      navigateAndFinish(context, ShopLoginScreen());
                  });
                },
                text: 'Log Out',
                titleIcon: Icons.logout_outlined,
              ),
            ],
          ),
        );
      },
    );
  }
}
