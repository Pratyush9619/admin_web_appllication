import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  String userId;
  MyDrawerHeader({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('assets/profile.png')),
              ),
              height: 70,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            Text(
              "USERID - ${userId} ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
