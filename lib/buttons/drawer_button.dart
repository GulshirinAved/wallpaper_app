import 'package:flutter/material.dart';

class Drawerbutton extends StatelessWidget {
  const Drawerbutton({
    Key key,
    this.text,
    this.icon,
    this.index,
  }) : super(key: key);

  final IconData icon;
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
    );
  }
}
