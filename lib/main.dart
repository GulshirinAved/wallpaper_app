import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tazewallpaper/constants/translation.dart';

import 'package:tazewallpaper/home/splashscreen.dart';

import 'constants/translation.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  String dil = 'en';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getString('yatdaSaklanDilim'));
  print("qwdddddddddddddddddddddddddddddddddddddddddddddddddnijniqnijnqiwndijwidjnqwijdniqdn");
  if (preferences.getString('yatdaSaklanDilim') != null) {
    dil = preferences.getString('yatdaSaklanDilim');
  } else {
    await preferences.setString("yatdaSaklanDilim", 'en');
  }

  runApp(
    MyApp(
      dill: dil,
    ),
  );
}

class MyApp extends StatefulWidget {
  final String dill;
  const MyApp({Key key, this.dill}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: translations(),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      home: ConnectionCheckpage(),
      locale: Locale(widget.dill),
    );
  }
}
