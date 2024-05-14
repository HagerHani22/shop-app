
import '../favorites/favourites_model.dart';
import '../login/login_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}
class ShopChangeNavBarStates extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccesscategoriesState extends ShopStates{}
class ShopErrorcategoriesState extends ShopStates{
  final String error;
  ShopErrorcategoriesState(this.error);
}


class ShopLoadingFavouritesState extends ShopStates{}
class ShopSuccessFavouritesState extends ShopStates{}
class ShopErrorFavouritesState extends ShopStates{
  final String error;
  ShopErrorFavouritesState(this.error);
}


class ShopChangeFavouritesState extends ShopStates{}
class ShopSuccessChangeFavouritesState extends ShopStates  {
  final ChangeFavouritesModel model;
  ShopSuccessChangeFavouritesState(this.model) ;
  }
class ShopErrorChangeFavouritesState extends ShopStates{}


class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{
  final String error;
  ShopErrorUserDataState(this.error);
}
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{
  final String error;
  ShopErrorUpdateUserState(this.error);
}