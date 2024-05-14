import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/shop_app/register/states.dart';


import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../layout/shop_layout.dart';
import 'cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  // ShopLoginScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if (state is ShopRegisterSuccessStates) {
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
        var cubit = ShopRegisterCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Register now to browser our hot offers.',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Your name',
                          prefix: Icons.person,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter Your name';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller:emailController,
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
                          controller: phoneController,
                          type: TextInputType.number,
                          label: 'Your Phone',
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter Your Mobile Number';
                            }else if (!RegExp(r'(^(010|012|015|011)\d{8}$)').hasMatch(value)) {
                              return 'Please enter a valid Mobile Number';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Your Password',
                          onSubmitted: (value) {
                            if (formkey.currentState!.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
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
                      state is! ShopRegisterLoadingStates
                          ? defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            cubit.userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'Register',
                        background: HexColor('3d8069'),
                      )
                          : const Center(child: CircularProgressIndicator()),

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
