import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_cubit.dart';
import 'package:shop_app/layout/cubit/layout_states.dart';

import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<BoxShadow>? boxShadow = [const BoxShadow(blurRadius: 20)];
        return ListView.separated(
            itemBuilder: (context, index) => categoryItem(boxShadow,ShopLayoutCubit.get(context)
                .categoriesModel!
                .data
                .data[index]),
            separatorBuilder:(context, index) =>  const SizedBox(height: 0,),
            itemCount:ShopLayoutCubit.get(context)
                .categoriesModel!
                .data
                .data.length );
      },
    );
  }
  Widget categoryItem(List<BoxShadow>? boxShadow,DataModel model)=>Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: boxShadow,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
        ),
        const SizedBox(width: 5,),
         Text(model.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
