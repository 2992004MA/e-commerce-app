import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/favorite_model.dart';

import '../../shared/components/component.dart';
import '../../shared/style/colors.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoriteSuccessstate) {
          if (!state.model.status!)
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          else
            showToast(text: state.model.message!, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,int index) => buildFavItem(ShopCubit.get(context).favoriteModel!.data!.data![index] , context),
          separatorBuilder: (context, index) => SizedBox(height: 0,),
          itemCount: ShopCubit.get(context).favoriteModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildFavItem(FavoriteData model , context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 7.0),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Image(
                        image: NetworkImage(
                            '${model.product!.image}'),
                        // fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      if (model.product!.discount != 0)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(4)),
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
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.product!.name}',
                          // textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.04,),
                        Row(
                          children: [
                            Text(
                              '${model.product!.price!.round()}',
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
                            if (model.product!.discount != 0)
                              Text(
                                '${model.product!.oldPrice!.round()}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  height: 1,
                                  fontFamily: 'Pacifico',
                                  color: Colors.black38,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        IconButton(
          onPressed: () {
            ShopCubit.get(context).changeFavorites(model.product!.id!);
          },
          icon: Icon(
            ShopCubit.get(context).favorites[model.product!.id]! ? Icons.favorite : Icons.favorite_border,
            color: defaultColor,
            size: 19,
          ),
        ),
      ],
    ),
  );
}
