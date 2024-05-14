import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/shop_app/login/states.dart';


import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../layout/shop_layout.dart';
import '../register/register_screen.dart';
import 'cubit.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessStates) {
          if (state.loginModel.status!) {
            print(state.loginModel.data?.token);
            print(state.loginModel.message);
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data?.token)
                .then((value) {
                   token=state.loginModel.data?.token;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                  (route) => false);
            });
          } else {
            print(state.loginModel.message);
            showToast(
              text: state.loginModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'login now to browser our hot offers.',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: cubit.emailController,
                          type: TextInputType.emailAddress,
                          label: 'Your Email',
                          prefix: Icons.email,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter your email';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: cubit.passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Your Password',
                          onSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                              );
                            }
                          },
                          ispassword: cubit.isPassword,
                          prefix: Icons.lock,
                          suffix: cubit.icon,
                          suffixPressed: () {
                            cubit.changeSuffix();
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter your Password';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      state is! ShopLoginLoadingStates
                          ? defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                  );
                                }
                              },
                              text: 'Login',
                              background: HexColor('3d8069'),
                            )
                          : const Center(child: CircularProgressIndicator()),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopRegisterScreen(),));
                                }, child: const Text('Register Now')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
