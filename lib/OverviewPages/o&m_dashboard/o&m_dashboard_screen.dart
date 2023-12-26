import 'package:flutter/material.dart';

class ONMDashboard extends StatefulWidget {
  const ONMDashboard({super.key});

  @override
  State<ONMDashboard> createState() => _ONMDashboardState();
}

class _ONMDashboardState extends State<ONMDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ONM Dashboard"),
          ],
        ),
      ),
    );
  }
}
