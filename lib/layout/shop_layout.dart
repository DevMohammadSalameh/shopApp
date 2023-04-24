import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_cubit.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'cubit/layout_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context) => ShopLayoutCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
         child:  BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ShopLayoutCubit.get(context);

            return Scaffold(
                appBar: AppBar(
                  title: const Text("shoppi"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        navigateTo(context, const SearchScreen());
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
                //temp
                body: cubit.layoutScreens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index){
                    cubit.changeBottomNav(index);
                  },
                  currentIndex: cubit.currentIndex,
                  selectedItemColor: secondaryColor,
                  items:  const [
                    BottomNavigationBarItem(
                      icon:  Icon(Icons.home,color: primaryColor,),
                      label: "Home",
                    activeIcon:  Icon(Icons.home,color: secondaryColor,)),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.apps,color: primaryColor,),
                      label: "Categories",
                      activeIcon: Icon(Icons.apps,color: secondaryColor,),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite,color: primaryColor,),
                      label: "Favorites",
                      activeIcon: Icon(Icons.favorite,color: secondaryColor,)
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings,color: primaryColor,),
                      label: "Settings",
                      activeIcon: Icon(Icons.settings,color: secondaryColor,)
                    ),
                  ],
                )
            );
          },)

    );
  }
}
