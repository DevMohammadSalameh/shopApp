import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../modules/categories/categories_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> layoutScreens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ShopLayoutChangeNavState());
  }

   HomeModel? homeModel;

  void getHomeData()  {
     DioHelper.getData(
       url: HOME,
       token: token,
     ).then((value) {
       // printFullText("Value.Data => ${value.data}");
      homeModel = HomeModel.fromJson(value.data);
      // print("Look here =>${homeModel.data.products[0].name.toString()}");
      emit(ShopLayoutSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopLayoutErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories()  {
     DioHelper.getData(
       url: GET_CATEGORIES,
       token: token,
     ).then((value) {
       categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopLayoutSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString()); //for some reason the
      emit(ShopLayoutErrorCategoriesState());
    });
  }
}
