
import 'package:flutter/material.dart';
import '../style.dart';

class NoInterneet extends StatelessWidget {
  const NoInterneet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 200,
            color: blue,
          ),
          const Text(
            'Whoops!!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'No Internet Connection was found. check Your Internet Connection',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
