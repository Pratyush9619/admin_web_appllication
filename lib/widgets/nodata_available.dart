import 'package:flutter/material.dart';

import '../style.dart';

class NodataAvailable extends StatefulWidget {
  const NodataAvailable({super.key});

  @override
  State<NodataAvailable> createState() => _NodataAvailableState();
}

class _NodataAvailableState extends State<NodataAvailable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 800,
        width: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: blue)),
        child: Column(children: [
          Image.asset(
            'assets/Tata-Power.jpeg',
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/sustainable.jpeg',
                height: 100,
                width: 100,
              ),
              SizedBox(width: 70),
              Image.asset(
                'assets/Green.jpeg',
                height: 100,
                width: 100,
              )
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: blue)),
              child: const Text(
                '     No data available yet \n Please wait',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    )));
  }
}
