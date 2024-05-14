
import '../favorites/favourites_model.dart';

abstract class ShopSearchStates{}
class ShopSearchInitialStates extends ShopSearchStates{}

class ShopSearchLoadingStates extends ShopSearchStates{}

class ShopSearchSuccessStates extends ShopSearchStates {}

class ShopSearchErrorStates extends ShopSearchStates{}

class ShopSearchChangeFavouritesState extends ShopSearchStates{}
class ShopSearchSuccessChangeFavouritesState extends ShopSearchStates  {
  final ChangeFavouritesModel model;
  ShopSearchSuccessChangeFavouritesState(this.model) ;
}
class ShopSearchErrorChangeFavouritesState extends ShopSearchStates{}


class ShopSearchLoadingFavouritesState extends ShopSearchStates{}
class ShopSearchSuccessFavouritesState extends ShopSearchStates{}
class ShopSearchErrorFavouritesState extends ShopSearchStates{
  final String error;
  ShopSearchErrorFavouritesState(this.error);
}


class ShopSearchLoadingHomeDataState extends ShopSearchStates{}
class ShopSearchSuccessHomeDataState extends ShopSearchStates{}
class ShopSearchErrorHomeDataState extends ShopSearchStates{
  final String error;
  ShopSearchErrorHomeDataState(this.error);
}