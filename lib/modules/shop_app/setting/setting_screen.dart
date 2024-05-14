import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../login/shop_login.dart';

var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubits, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubits.get(context);
        var model = cubit.userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return cubit.userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserState)
                          const LinearProgressIndicator(),
                        const SizedBox(height: 10,),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: ' Name',
                          prefix: Icons.person,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter your phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          function: () {
                            if(formKey.currentState!.validate()){
                              cubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                  
                          },
                          text: 'Update',
                          background: HexColor('3d8069'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          function: () {
                            CacheHelper.removeData(key: 'token').then((value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShopLoginScreen(),
                                    ),
                                    (route) => false);
                              }
                            });
                          },
                          text: 'logout',
                          background: HexColor('3d8069'),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: HexColor('3d8069'),
                ),
              );
      },
    );
  }
}
