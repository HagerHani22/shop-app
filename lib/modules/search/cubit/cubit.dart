import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';


import '../../../../shared/components/constants.dart';
import '../../../../shared/network/end_point.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../models/favourites_model.dart';

class ShopSearchCubits extends Cubit<ShopSearchStates>{
  ShopSearchCubits():super(ShopSearchInitialStates());
  static ShopSearchCubits get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text,context){
    emit(ShopSearchLoadingStates());
    DioHelper.postData(url: searchUrl, data: {
      'text':text,
      'token':token,
    }).then((value){
      searchModel=SearchModel.fromJson(value.data);
      searchModel!.data!.data!.forEach((element) {
        favorites.addAll({
          element.id!: element.infavorites!,
        });
      });
      emit(ShopSearchSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorStates());
    });
  }


  Map<int, bool> favorites = {};


  ChangeFavouritesModel? changeFavouritesModel;
  Future<void> changeFavourite(int productId,context) async {
   favorites[productId] =! favorites[productId]!;
    emit(ShopSearchChangeFavouritesState());
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
      emit(ShopSearchSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error) {
      favorites [productId] =! favorites[productId]!;

      emit(ShopSearchErrorChangeFavouritesState());
    });
  }


  FavouriteModel? favouritesModel;
  void getFavourite() {
    emit(ShopSearchLoadingFavouritesState());
    DioHelper.getData(
      url: favouriteUrl,
      token: token,
    ).then((value) {
      favouritesModel = FavouriteModel.fromJson(value.data);
      emit(ShopSearchSuccessFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorFavouritesState(error.toString()));
    });
  }



}