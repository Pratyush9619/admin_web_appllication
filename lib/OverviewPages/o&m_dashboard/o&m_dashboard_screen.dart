import 'package:flutter/material.dart';
import 'package:web_appllication/style.dart';

class ONMDashboard extends StatefulWidget {
  final bool showAppBar;
  const ONMDashboard({super.key, this.showAppBar = false});

  @override
  State<ONMDashboard> createState() => _ONMDashboardState();
}

class _ONMDashboardState extends State<ONMDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: AppBar(
                centerTitle: true,
                backgroundColor: blue,
                title: const Text('O & M Analysis Dashboard'),
              ),
            )
          : null,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("ONM Dashboard"),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 35,
            width: 100,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: white,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Back', style: TextStyle(color: white)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 35,
            width: 140,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.upload_file_outlined,
                      color: white,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Upload Excel', style: TextStyle(color: white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
