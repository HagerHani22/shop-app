class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromjson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  bool? infavorites;
  bool? incart;

  ProductsModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorites = json['in_favorites'];
    incart = json['in_cart'];
  }
}
