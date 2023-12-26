import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:web_appllication/Authentication/login.dart';
import 'package:web_appllication/Authentication/register.dart';
import 'package:web_appllication/style.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: 450,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/webhome.jpeg'),
                    fit: BoxFit.fill)),
          ),
        ),
        Expanded(
          child: Container(
            width: 600,
            child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(220),
                    child: Column(children: [
                      _space(10),
                      Text("EV Monitoring System.", style: headline5White),
                      _space(5),
                      Text("Login to access your account below!",
                          style: subtitle1White60),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Green.jpeg',
                              height: 70,
                              width: 70,
                            ),
                            Image.asset(
                              'assets/sustainable.jpeg',
                              height: 70,
                              width: 70,
                            ),
                          ],
                        ),
                      ),
                      _space(5),
                      TabBar(
                        labelColor: green,
                        labelStyle: buttonWhite,
                        unselectedLabelColor: blue,

                        //indicatorSize: TabBarIndicatorSize.label,
                        indicator: MaterialIndicator(
                          horizontalPadding: 24,
                          bottomLeftRadius: 8,
                          bottomRightRadius: 8,
                          color: almostblack,
                          paintingStyle: PaintingStyle.fill,
                        ),

                        tabs: const [
                          Tab(
                            text: "Sign In",
                          ),
                          Tab(
                            text: "Register",
                          ),
                        ],
                      ),
                    ]),
                  ),
                  body: const TabBarView(children: [
                    SignInPage(),
                    RegisterPage(),
                  ]),
                )),
          ),
        ),
      ],
    );
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }
}
