import 'package:flutter/material.dart';

class TableLoading extends StatelessWidget {
  const TableLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: Image.asset('animations/loading_animation.gif'),
            ),
          ),
          const Text(
            'Please Wait',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
