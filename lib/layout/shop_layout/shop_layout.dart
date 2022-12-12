import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/component.dart';

import '../../shared/style/colors.dart';

class ShopLayout extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategoryData()..getFavorite()..getUserData(),
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Pacifico',
                    fontSize: 30
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: defaultColor,
              onPressed: () {
                navigaiteTo(context, SearchScreen());
              },
              child: Icon(Icons.search),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: ShopCubit.get(context).icons,
              activeIndex: ShopCubit.get(context).currentIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.values[3],
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              activeColor: defaultColor,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              //other params
            ),
          );
        },
      ),
    );
  }
}
