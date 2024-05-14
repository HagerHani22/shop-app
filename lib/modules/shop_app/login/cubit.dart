import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login/states.dart';

import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'login_model.dart';

LoginModel ?loginModel;

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopInitialStates());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    print(email);
    print(password);
    emit(ShopLoginLoadingStates());
    DioHelper.postData(url: loginUrl, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);

      // print(loginModel?.data?.token);
      // print(loginModel?.status);
      // print(loginModel?.message);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  IconData icon = Icons.visibility_off;
  bool isPassword = true;
  void changeSuffix() {
    isPassword = !isPassword;
    icon = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ShopChangeIconStates());
  }
}
