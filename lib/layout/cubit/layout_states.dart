import 'package:shop_app/models/favorite_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopLayoutChangeNavState extends ShopLayoutStates {}

class ShopLayoutLoadingHomeDataState extends ShopLayoutStates{}

class ShopLayoutSuccessHomeDataState extends ShopLayoutStates{}

class ShopLayoutErrorHomeDataState extends ShopLayoutStates{}

class ShopLayoutSuccessCategoriesState extends ShopLayoutStates{}

class ShopLayoutErrorCategoriesState extends ShopLayoutStates{}

class ShopLayoutSuccessLocalChangeFavState extends ShopLayoutStates{}

class ShopLayoutSuccessChangeFavState extends ShopLayoutStates{
  late FavoriteModel model;

  ShopLayoutSuccessChangeFavState(this.model);
}

class ShopLayoutErrorChangeFavState extends ShopLayoutStates{}

class ShopLayoutLoadingGetFavoritesState extends ShopLayoutStates{}

class ShopLayoutSuccessGetFavoritesState extends ShopLayoutStates{}

class ShopLayoutErrorGetFavoritesState extends ShopLayoutStates{}

class ShopLayoutLoadingUserDataState extends ShopLayoutStates{}

class ShopLayoutSuccessUserDataState extends ShopLayoutStates{}

class ShopLayoutErrorUserDataState extends ShopLayoutStates{}
