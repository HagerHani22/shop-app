class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  // LoginModel({
  //   this.status,
  //   this.message,
  //   this.data,
  // });
LoginModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  message=json['message'];
  data=json['data'] !=null ?UserData.fromJson(json['data']) : null;
}
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.phone,
  //   this.email,
  //   this.image,
  //   this.points,
  //   this.credit,
  //   this.token,
  // });

  //Named constru  ctor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
