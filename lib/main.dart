import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/Authentication/login_register.dart';
import 'package:web_appllication/provider/All_Depo_Select_Provider.dart';
import 'package:web_appllication/provider/assigned_user_provider.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/provider/energy_provider.dart';
import 'package:web_appllication/provider/key_provider.dart';
import 'package:web_appllication/provider/menuUserPageProvider.dart';
import 'package:web_appllication/provider/selected_row_index.dart';
import 'package:web_appllication/provider/text_provider.dart';
import 'package:web_appllication/routeBuilder/route_generator.dart';
import 'package:web_appllication/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCrSwVB12UIZ_wiLcsIqDeXb3cP6QKkMgM',
          appId: '1:787886302853:web:a13e1fc1f32187fcc26bec',
          messagingSenderId: '787886302853',
          storageBucket: "tp-zap-solz.appspot.com",
          projectId: 'tp-zap-solz'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DemandEnergyProvider()),
        ChangeNotifierProvider(create: (_) => MenuUserPageProvider()),
        ChangeNotifierProvider<AssignedUserProvider>(
            create: (_) => AssignedUserProvider()),
        ChangeNotifierProvider<textprovider>(
          create: (context) => textprovider(),
        ),
        ChangeNotifierProvider<KeyProvider>(create: (context) => KeyProvider()),
        ChangeNotifierProvider(create: (context) => SelectedRowIndexModel()),
        ChangeNotifierProvider(create: (context) => AllDepoSelectProvider()),
        ChangeNotifierProvider(create: (context) => EnergyProvider())
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'TATA POWER CONTROL PANEL',
        // initialRoute: '/demand',
        // routes: {
        //   // DashBoardScreen.id: (context) => SmallScreen(),
        //   MenuUserPage.id: (context) => const MenuUserPage(),
        //   ProjectPanning.id: (context) => const ProjectPanning(),

        //   // "/menu": (context) => Menu(),
        //   // "/user": (context) => User(),
        //   // "/shop": (context) => Shop(),
        //   // "/statistics": (context) => Stats(),
        //   // "/settings": (context) => Settings() .
        // },

        theme: ThemeData(
          primarySwatch: Colors.blue,
          dividerColor: grey,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                6,
              ),
              borderSide: BorderSide(
                color: grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                6,
              ),
              borderSide: BorderSide(
                color: blue,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusColor: almostWhite,
            labelStyle: bodyText2White60,
          ),
        ),
        home: const MyHomePage(),
      ),
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
    return
        //  SplitDashboard();
        //  DemandEnergyScreen();
        // ExperimentalTable();
        // AnimatedDataTable();
        LoginRegister();
    //  DemandEnergyScreen();
    // NavigationPage(
    //   userId: '',
    // );
    //  SplitDashboard();
    //  NavigationPage();
    // DashBoardScreen();
    // SmallScreen();
    // MenuUserPage();
    // DepotOverview();
    // ResourceAllocation();
    //  EventsPage();
    // KeyEvents();
    // const CitiesPage();
    // const LoginRegister();
    // const PdfSummary();
  }
}
