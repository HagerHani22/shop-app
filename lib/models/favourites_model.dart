
import 'home_model.dart';

class ChangeFavouritesModel{
  bool ?status;
  String ?message;
  ChangeFavouritesModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}
////////////////////////////////////////////////////////////////////////





class FavouriteModel {
  bool? status;
  String? message;
  Data? data;


  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<FavData>?  data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(FavData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];

  }

}

class  FavData{
  int? id;
 ProductsModel?product;
  FavData.fromJson(Map<String, dynamic>json){
    id=json['id'];
    product=json['product'] != null ?ProductsModel.fromjson(json['product']):null;
  }

}




