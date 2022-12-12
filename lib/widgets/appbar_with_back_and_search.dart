import 'package:flutter/material.dart';
import 'package:web_appllication/style.dart';

class AppBarWithBack extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final double height;
  final bool haveSearch;

  const AppBarWithBack(
      {super.key,
      required this.text,
      this.height = 55,
      this.haveSearch = false});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      actions: [
        haveSearch ? const Icon(Icons.search_rounded) : Container(),
        const SizedBox(
          width: 10,
        ),
      ],
      title: Text(
        text,
        style: TextStyle(color: white),
      ),
    );
  }
}
