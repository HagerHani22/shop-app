import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../../models/home_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../models/categories_model.dart';
import '../../../models/favourites_model.dart';
import '../../../models/login_model.dart';
import '../../modules/shop_app/categories/categories_screen.dart';
import '../../modules/shop_app/favorites/favorites_screen.dart';
import '../../modules/shop_app/products/products_screen.dart';
import '../../modules/shop_app/setting/setting_screen.dart';

class ShopCubits extends Cubit<ShopStates> {
  ShopCubits() : super(ShopInitialStates());
  static ShopCubits get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];
  int currentIndex = 0;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeNavBar(index) {
    currentIndex = index;
    emit(ShopChangeNavBarStates());
  }


  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: homeUrl,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel?.data?.banners[0].image);
      // print(homeModel?.message);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.infavorites!,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: categoriesUrl,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccesscategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorcategoriesState(error.toString()));
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  Future<void> changeFavourite(int productId) async {
    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavouritesState());
   await DioHelper.postData(
      url: favouriteUrl,
      data: {
        'product_id': productId,
      },
      token:token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavouritesModel!.status!) {
        favorites[productId] =! favorites[productId]!;
      }else{
        getFavourite();
        }
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavouritesState());
    });
  }


  FavouriteModel? favouritesModel;
  void getFavourite() {
    emit(ShopLoadingFavouritesState());
    DioHelper.getData(
      url: favouriteUrl,
      token: token,
    ).then((value) {
      favouritesModel = FavouriteModel.fromJson(value.data);
      emit(ShopSuccessFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavouritesState(error.toString()));
    });
  }



  LoginModel ?userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: profileUrl,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone,
}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: Update_Profile,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState(error.toString()));
    });
  }





}
