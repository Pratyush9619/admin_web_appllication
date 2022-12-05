import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static const String id = 'admin-page';
  AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data')),
    );
  }
}
