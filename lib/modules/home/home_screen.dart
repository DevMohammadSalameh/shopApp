import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_cubit.dart';
import 'package:shop_app/layout/cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopLayoutSuccessChangeFavState){
         if(!state.model.status){
           showToast(text: state.model.message, state: ToastStates.ERROR);
         }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => homeBuilder(cubit.homeModel, cubit.categoriesModel,context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 3,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => categoryItem(categoriesModel.data.data[index]),
                separatorBuilder: (context, index) => const SizedBox(width: 0,),
                itemCount: categoriesModel!.data.data.length),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.75,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
              children: List.generate(model!.data.products.length,
                  (index) => productItem(model.data.products[index],context)),
            ),
          ),
          CarouselSlider(
              items: model.data.banners.map(
                    (e) {
                  return Image(
                    image: NetworkImage(
                      e.image,
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayCurve: Curves.linear,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              )),
        ],
      ),
    );
  }

  Widget productItem(ProductModel model,context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image,
                  scale: 1,
                ),
                height: 200,
                width: double.infinity,
              ),
              ConditionalBuilder(
                condition: model.discount != 0,
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
          Text(
            model.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                model.price.toString(),
                style: const TextStyle(
                  fontSize: 14.0,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (model.discount != 0)
                Text(
                  model.oldPrice.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  ShopLayoutCubit.get(context).changeFav(model.id);
                  // print( model.id);
                },
                icon: ConditionalBuilder(
                  condition: ShopLayoutCubit.get(context).productsWithIsFav[model.id]??false,
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
            ],
          )
        ],
      ),
    );
  }

  Widget categoryItem(DataModel model)=> Container(
    margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(
        color: primaryColor,
        width: 5,
        style: BorderStyle.solid,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child:   Center(
      child: Text(model.name,style: const TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),),
    ),
  );
}
