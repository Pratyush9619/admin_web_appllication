import 'package:flutter/material.dart';

class Home2 extends StatelessWidget {
  static const String id = 'homepage2';
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('assets/HomePage.jpeg'),
      ),
    );
  }
}
