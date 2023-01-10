import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tazewallpaper/home/home_page.dart';
import 'package:tazewallpaper/onboarding/functiononboarding.dart';

class OnboardingCheckPage extends StatefulWidget {
  const OnboardingCheckPage({Key key}) : super(key: key);

  @override
  State<OnboardingCheckPage> createState() => _OnboardingCheckPageState();
}

class _OnboardingCheckPageState extends State<OnboardingCheckPage> {
  final controller = LiquidController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        LiquidSwipe(
          onPageChangeCallback: (index) {
            setState(() {});
          },
          liquidController: controller,
          pages: page,
          slideIconWidget: const Icon(
            IconlyLight.arrowLeft2,
            size: 30,
          ),
          positionSlideIcon: 0.9,
          waveType: WaveType.liquidReveal,
          enableLoop: false,
          enableSideReveal: true,
          fullTransitionValue: 700,
        ),
        Positioned(
          bottom: 135,
          left: 150,
          child: AnimatedSmoothIndicator(
              activeIndex: controller.currentPage,
              count: 3,
              curve: Curves.linear,
              effect: const ExpandingDotsEffect(dotHeight: 5, radius: 20, dotColor: Color.fromARGB(255, 244, 241, 221), activeDotColor: Colors.yellow, spacing: 5),
              onDotClicked: (index) {
                controller.animateToPage(page: index);
              }),
        ),
      ]),
    );
  }
}

final page = [
  /// sahypa 1;
  OnboardingChecking(
      image: "asset/onboardingimage/2.jpg",
      color: Colors.white,
      text: "Welcome!",
      text2: "Join with Us & Enjoy Happy Life",
      fontfamily: "Raleway-VariableFont_wght",
      fontsize: 50.0,
      colortext: Colors.amber,
      fontweight: FontWeight.bold,
      fontfamily2: "gilroy-medium",
      fontsize2: 20,
      colortext2: Colors.black),

  ///sahypa 2;
  OnboardingChecking(
    image: "asset/onboardingimage/7.jpg",
    color: Colors.white,
    text: "New Day",
    colortext: Colors.orange,
    fontfamily: "Raleway-VariableFont_wght",
    fontweight: FontWeight.bold,
    fontsize: 50,
    text2: "New Atmosphere",
    fontfamily2: "gilroy-medium",
    fontsize2: 40,
    colortext2: const Color.fromARGB(255, 216, 8, 171),
  ),

  ///sahypa 3;
  OnboardingChecking(
      image: "asset/onboardingimage/6.jpg",
      color: Colors.amberAccent,
      text: "Life is too short",
      fontfamily: 'PlayfairDisplaySC-BlackItalic',
      fontsize: 25,
      colortext: Colors.white,
      text2: "to have boring Wallpaper",
      fontfamily2: 'PlayfairDisplaySC-BlackItalic',
      fontsize2: 23,
      colortext2: Colors.white,
      donebutton: TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Get.to(() => const MyHomePage());
        },
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 5, top: 8),
            child: const Center(
              child: Text('Done', style: TextStyle(color: Colors.amber, fontSize: 30, fontFamily: "gilroy-medium")),
            )),
      ))
];
