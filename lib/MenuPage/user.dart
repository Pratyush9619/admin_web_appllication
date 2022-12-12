import 'package:flutter/material.dart';

class MenuUserPage extends StatefulWidget {
  static const String id = 'user-page';
  const MenuUserPage({super.key});

  @override
  State<MenuUserPage> createState() => _MenuUserPageState();
}

class _MenuUserPageState extends State<MenuUserPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('User Page'),
    ));
  }
}
