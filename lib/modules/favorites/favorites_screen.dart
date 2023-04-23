import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_cubit.dart';
import 'package:shop_app/layout/cubit/layout_states.dart';
import '../../models/favorite_model.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BoxShadow>? boxShadow = [const BoxShadow(blurRadius: 20)];
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).favoritesModel;
        return ConditionalBuilder(
          condition: state is! ShopLayoutLoadingGetFavoritesState,
          builder:(context) => ListView.builder(
            itemBuilder: (context, index) =>
                favoriteItem(boxShadow, model!.data!.data![index], context),
            itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) =>  const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget favoriteItem(List<BoxShadow>? boxShadow,Data model, context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: boxShadow,
      ),
      height: 120,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.product!.image.toString(),
                  ),
                  height: 120,
                  width: 120,
                ),
                ConditionalBuilder(
                  condition: model.product!.discount != 0,
                  builder: (context) => Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  fallback: (context) => Container(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        model.product!.price.toString(),
                        //model.price.toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: primaryColor,
                        ),
                      ),
                      const Spacer(),
                      if (model.product!.oldPrice != 0)
                        Text(
                          model.product!.oldPrice.toString(),
                          // model.oldPrice.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                ShopLayoutCubit.get(context).changeFav(model.product!.id);
                // print( model.id);
              },
              icon: ConditionalBuilder(
                condition:
                    ShopLayoutCubit.get(context).productsWithIsFav[model.product!.id] ?? false,
                builder: (context) => const Icon(
                  Icons.favorite,
                  color: primaryColor,
                ),
                fallback: (context) => const Icon(
                  Icons.favorite_border,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
