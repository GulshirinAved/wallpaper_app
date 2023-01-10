import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FunctionAboutChecking extends StatelessWidget {
  final String name;
  final String name2;
  final IconData icon;
  final String launchtext;

  const FunctionAboutChecking({Key key, this.name, this.name2, this.icon, this.launchtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  launch(launchtext);
                },
                child: SizedBox(
                  height: 100,
                  width: 130,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'gilroy-bold',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  launch(launchtext);
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Text(
                    name2,
                    style: const TextStyle(
                      fontSize: 19,
                      fontFamily: "gilroy-medium",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
