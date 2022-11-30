import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/Authentication/login_register.dart';
import 'package:web_appllication/small_screen.dart';
import 'package:web_appllication/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCrSwVB12UIZ_wiLcsIqDeXb3cP6QKkMgM',
          appId: '1:787886302853:web:a13e1fc1f32187fcc26bec',
          messagingSenderId: '787886302853',
          projectId: 'tp-zap-solz'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TATA Web Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SmallScreen();
  }
}
