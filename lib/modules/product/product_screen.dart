import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';

import '../../models/category_model.dart';
import '../../shared/components/component.dart';
import '../../shared/style/colors.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoriteSuccessstate) {
          if (!state.model.status!)
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          else
            showToast(text: state.model.message!, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null,
          builder: (context) =>
              productBuilder(ShopCubit.get(context).homeModel, context),
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: defaultColor,
          )),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model, context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model!.data!.banners!
                  .map((e) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: NetworkImage(
                            '${e.image}',
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 220,
                aspectRatio: 16 / 9,
                viewportFraction: 0.7,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(ShopCubit.get(context).categoryModel!.data!.data![index]),
                        separatorBuilder: (context, index) => SizedBox(width: 5,),
                        itemCount: ShopCubit.get(context).categoryModel!.data!.data!.length,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      'New Products',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 0,
              childAspectRatio: 1 / 1.35,
              children: List.generate(
                  model.data!.products!.length,
                  (index) =>
                      buildGridProduct(model.data!.products![index], context)),
            ),
          ],
        ),
      );

  Widget buildGridProduct(Product model, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .31,
              child: Card(
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image(
                          image: NetworkImage(model.image!),
                          // fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                        if (model.discount != 0)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(4)),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.only(top: 2.0),
                            height: 15.0,
                            width: 45,
                            child: Text(
                              'Discount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '${model.name}',
                        // textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: [
                          Text(
                            '${model.price!.round()}',
                            style: TextStyle(
                              height: 1,
                              fontFamily: 'Pacifico',
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice!.round()}',
                              style: TextStyle(
                                fontSize: 12.0,
                                height: 1,
                                fontFamily: 'Pacifico',
                                color: Colors.black38,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            alignment: Alignment.center,
                              onPressed: (){
                                ShopCubit.get(context).changeFavorites(model.id!);
                              },
                              icon: CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.grey[100],
                                child: Icon(
                                  ShopCubit.get(context).favorites[model.id]! ? Icons.favorite : Icons.favorite_border_outlined ,
                                  color: defaultColor,
                                  size: 18,
                                ),
                              ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  
  Widget buildCategoryItem(Datum model) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          model.name!,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
