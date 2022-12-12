import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';

import '../../models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoryModel!.data!.data![index] , context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: ShopCubit.get(context).categoryModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(Datum model , context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
          children: [
            Image(image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                '${model.name}',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          Icon(Icons.arrow_forward_ios),
          ],
        ),
  );
}
