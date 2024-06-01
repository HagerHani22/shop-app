import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../modules/search/search_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubits, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubits cubit = ShopCubits.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Salla',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            actions: [
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
              }, icon: const Icon(Icons.search,)),
              // TextButton(
              //     onPressed: () {
              //       CacheHelper.removeData(key: 'token').then((value) {
              //         if (value) {
              //           Navigator.pushAndRemoveUntil(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => ShopLoginScreen(),
              //               ),
              //               (route) => false);
              //         }
              //       });
              //     },
              //     child: Text(
              //       'Sign Out',
              //       style: TextStyle(
              //         color: HexColor('3d8069'),
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //       ),
              //     )),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
              selectedItemColor: HexColor('3d8069'),
              unselectedItemColor: Colors.grey,
              items: cubit.bottomItems),
        );
      },
    );
  }
}
