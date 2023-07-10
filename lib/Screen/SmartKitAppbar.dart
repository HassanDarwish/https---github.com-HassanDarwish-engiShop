import 'package:flutter/material.dart';

class SmartKitAppbar extends StatelessWidget {
  final String title;
  const SmartKitAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: const TextStyle(color: Colors.black)),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }
}
