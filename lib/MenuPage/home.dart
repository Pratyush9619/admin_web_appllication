import 'package:flutter/material.dart';
import 'package:web_appllication/style.dart';

class MenuHomePage extends StatefulWidget {
  static const String id = 'homepage';
  const MenuHomePage({super.key});

  @override
  State<MenuHomePage> createState() => _MenuHomePageState();
}

class _MenuHomePageState extends State<MenuHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/HomePage.jpeg'),
    );
    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           height: 80,
    //           alignment: Alignment.topLeft,
    //           padding: const EdgeInsets.all(10),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(5), color: blue),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: Text(
    //               'Home Page',
    //               style: TextStyle(
    //                   fontWeight: FontWeight.w700, fontSize: 20, color: white),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Flexible(
    //               flex: 1,
    //               child: Container(
    //                 height: 120,
    //                 width: 200,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(color: blue)),
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Container(
    //                 height: 120,
    //                 width: 200,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(color: blue)),
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Container(
    //                 height: 120,
    //                 width: 200,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(color: blue)),
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Container(
    //                 height: 120,
    //                 width: 200,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(color: blue)),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       const SizedBox(height: 15),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Flexible(
    //               flex: 1,
    //               child: Container(
    //                 height: 400,
    //                 width: 400,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(color: blue)),
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Container(
    //                 height: 400,
    //                 width: 400,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(color: blue)),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 15),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Container(
    //               height: 400,
    //               width: 400,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   border: Border.all(color: blue)),
    //             ),
    //             Container(
    //               height: 400,
    //               width: 400,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   border: Border.all(color: blue)),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
