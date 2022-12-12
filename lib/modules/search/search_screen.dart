import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/component.dart';

import '../../layout/shop_layout/cubit/cubit.dart';
import '../../models/search_model.dart';
import '../../shared/style/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).search(text: value);
                          print(value.toString());
                        }
                      },
                      text: 'Search',
                      prefix: Icons.search,
                      validate: (value) {
                        if (value!.isEmpty) return 'search must not be empty';
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    if (state is SearchLoadingState)
                      SizedBox(
                        height: height * 0.01,
                      ),
                    if (state is SearchLoadingState)
                      LinearProgressIndicator(
                          color: defaultColor,
                          backgroundColor: defaultColor.withOpacity(0.6)),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: SearchCubit.get(context).model != null,
                        builder: (context) => ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context,
                                index),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: height * 0.01,
                                ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length),
                        fallback: (context) => Center(
                            child: Text(
                          'No Issues',
                          style: TextStyle(color: Colors.grey),
                        )),
                      ),
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

  Widget buildListProduct(SearchData model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              // fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    // textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
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
                ],
              ),
            ),
          ],
        ),
      );
}
