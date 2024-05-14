import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/register/states.dart';

import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../login/login_model.dart';


LoginModel? loginModel;

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    print(email);
    print(password);
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }

  IconData icon = Icons.visibility_off;
  bool isPassword = true;
  void changeSuffix() {
    isPassword = !isPassword;
    icon = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ShopRegisterChangeIconStates());
  }
}
