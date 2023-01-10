import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tazewallpaper/drawer/about_function.dart';

class AboutChecking extends StatefulWidget {
  final String name;
  final IconData icon;
  const AboutChecking({Key key, this.name, this.icon}) : super(key: key);

  @override
  State<AboutChecking> createState() => _AboutCheckingState();
}

class _AboutCheckingState extends State<AboutChecking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text(
            "about".tr,
            style: const TextStyle(fontSize: 25.0, color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15, left: 12),
                  child: Text(
                    "about1".tr,
                    style: const TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            const FunctionAboutChecking(
              name: "E-mail:",
              name2: "dadebaygurbanow333@gmail.com",
              launchtext: "mailto:dadebaygurbanow333@gmail.com?subjext=&body= ",
            ),
          ],
        ));
  }
}
