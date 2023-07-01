import 'package:flutter/material.dart';

class SmartKitAppbar extends StatelessWidget {
  final String title;
  SmartKitAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    );
  }
}
