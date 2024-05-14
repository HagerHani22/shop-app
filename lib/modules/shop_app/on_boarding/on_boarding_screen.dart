
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/Images/imageModel.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/shop_login.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () {
                submit (context);
                },
              child: Text(
                'SKIP',
                style: TextStyle(
                    color:HexColor('3d8069'),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: HexColor('fbf0e4'),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardController,
              onPageChanged: (int index) {
                if (index == details.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) => buildItems(details[index]),
              itemCount: details.length,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: details.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: HexColor('3d8069'),
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit (context);
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: HexColor('3d8069'),
                  shape: const CircleBorder(),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

Widget buildItems(ImageModel model) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(top: 100),
        child:
            Image(image: AssetImage('assets/image/shop.jpg'), fit: BoxFit.fill),
      ),
      const SizedBox(
        height: 80,
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('${model.address}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text('${model.content}',
            style: const TextStyle(
              fontSize: 20,
            )),
      ),
    ]);

List<ImageModel> details = [
  ImageModel(
    address: 'Screen Title 1',
    content: 'Screen subtitle 1',
  ),
  ImageModel(
    address: 'Screen Title 2',
    content: 'Screen subtitle 2',
  ),
  ImageModel(
    address: 'Screen Title 3',
    content: 'Screen subtitle 3',
  ),
];


void submit (context){
  CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
    if(value!){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute
        (builder: (context) => ShopLoginScreen(),),
            (route) => false,);
    }
  });
}