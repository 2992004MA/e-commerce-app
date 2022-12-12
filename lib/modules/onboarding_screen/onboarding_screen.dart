import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/shared_preference.dart';
import '../../shared/style/colors.dart';
import '../login_screen/login_screen.dart';

class BoardingModel {
  final String image;
  final String? body;

  BoardingModel({
    required this.image,
    this.body,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      body: 'You can find many merchants here at affordable prices and many discounts',
    ),
    BoardingModel(
      image: 'assets/images/onboarding2.jpg',
      body: 'making transaction here is very easy and we have cooperation with online payment companies',
    ),
    BoardingModel(
      image: 'assets/images/onboarding3.jpg',
      body: 'We provide freight forwarding services that deliver your ordered items with fast service',
    ),
    BoardingModel(
      image: 'assets/images/onboarding4_1.jpg',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.putBoolean(key: 'onBoarding', value: true).then((value) {
                navigateAndFinish(context, ShopLoginScreen());
              });
            },
            clipBehavior: Clip.antiAliasWithSaveLayer,

            style: ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder(side: BorderSide.none)),
            ),
            child: Text(
              'SKIP',
              style: TextStyle(
                color: defaultColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1)
                    setState(() {
                      isLast = true;
                    });
                  else
                    setState(() {
                      isLast = false;
                    });
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    boardController.nextPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                    if (isLast)
                      CacheHelper.putBoolean(key: 'onBoarding', value: true).then((value) {
                        navigateAndFinish(context, ShopLoginScreen());
                      });
                  },
                  backgroundColor: defaultColor,
                  child: isLast ? Icon(Icons.login) : Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 130),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        if(model.body != null)
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 19.0, color: Colors.black87.withOpacity(.7)),
        ),
      ],
    ),
  );
}
