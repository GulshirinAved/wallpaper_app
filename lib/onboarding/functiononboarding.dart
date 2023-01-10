import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tazewallpaper/home/home_page.dart';

class OnboardingChecking extends StatelessWidget {
  String image;
  String text;
  String text2;
  Color color;
  String fontfamily;
  double fontsize;
  Color colortext;
  FontWeight fontweight;
  String fontfamily2;
  double fontsize2;
  Color colortext2;
  TextButton donebutton;

  OnboardingChecking({
    Key key,
    this.image,
    this.text,
    this.color,
    this.text2,
    this.fontfamily,
    this.fontsize,
    this.colortext,
    this.fontweight,
    this.fontfamily2,
    this.fontsize2,
    this.colortext2,
    this.donebutton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Onboarding surat;
    return Container(
      width: double.infinity,
      color: color,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 86, bottom: 50),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: 350,
              width: 300,
            ),
          ),

          ///Onboarding text (suratyn asagyndaky);
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontFamily: fontfamily, fontSize: fontsize, color: colortext),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                text2,
                style: TextStyle(fontFamily: fontfamily2, fontSize: fontsize2, color: colortext2),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: donebutton,
              )
            ],
          )
        ],
      ),
    );
  }
}
