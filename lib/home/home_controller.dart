import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  changeLocalSettings(String dil) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("yatdaSaklanDilim", dil);
    if (dil == 'en') {
      Get.updateLocale(const Locale('en'));
    } else if (dil == 'ru') {
      Get.updateLocale(const Locale('ru'));
    } else if (dil == 'tm') {
      Get.updateLocale(const Locale('tm'));
    }
  }
}
