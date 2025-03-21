
import '../../../../models/login_model.dart';

abstract class ShopLoginStates{}
class ShopInitialStates extends ShopLoginStates{}
class ShopLoginLoadingStates extends ShopLoginStates{}
class ShopLoginSuccessStates extends ShopLoginStates
{
  final LoginModel loginModel;
  ShopLoginSuccessStates(this.loginModel,);
}
class ShopLoginErrorStates extends ShopLoginStates{
  final String error;
  ShopLoginErrorStates(this.error);
}

class ShopChangeIconStates extends ShopLoginStates{}
