import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/favorite_model.dart';
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

  Map<int, bool> productsWithIsFav = {};

  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data.products) {
        productsWithIsFav.addAll({element.id: element.inFavorites});
        // print({element.id: element.inFavorites});
      }
      emit(ShopLayoutSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopLayoutErrorHomeDataState());
    });
  }

  FavoriteModel? favoriteModel;

  void changeFav(int id) {
    productsWithIsFav[id] = !productsWithIsFav[id]!;
    emit(ShopLayoutSuccessLocalChangeFavState());

    DioHelper.postData(
      url: FAVORITE,
      data: {
        "product_id": id,
      },
      authorization: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      if (!favoriteModel!.status) {
        productsWithIsFav[id] = !productsWithIsFav[id]!;
      }else{
        getFavorites();
      }
      emit(ShopLayoutSuccessChangeFavState(favoriteModel!));
    }).catchError((error) {
      productsWithIsFav[id] = !productsWithIsFav[id]!;
      // print(error.toString());
      emit(ShopLayoutErrorChangeFavState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
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

FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLayoutLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopLayoutSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorGetFavoritesState());
    });
  }

}
