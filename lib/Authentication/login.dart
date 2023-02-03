//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_appllication/Authentication/reset_password.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/main.dart';
import 'package:web_appllication/small_screen.dart';

import '../style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isloading = false;
  String _id = "";
  String _pass = "";
  bool _isHidden = true;
  late SharedPreferences _sharedPreferences;
  // AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading
            ? LoadingPage()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  reverse: false,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            _space(16),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                labelText: "Employee ID",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _id = value;
                                });
                                debugPrint(_id);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Employee Id is required';
                                }

                                // if (!RegExp(
                                //         r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                //     .hasMatch(value)) {
                                //   return 'Please enter a valid email address';
                                // }

                                return null;
                              },
                              style: bodyText2White60,
                              keyboardType: TextInputType.emailAddress,
                              // onSaved: (value) {
                              //      updateEmail(context, value!, ref);
                              //   _email = value;
                              // },
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) => login(),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: _togglePasswordView,
                                    child: _isHidden
                                        ? const Icon(Icons.visibility)
                                        : Icon(
                                            Icons.visibility_off,
                                            color: grey,
                                          )),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                labelText: "Password",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is required';
                                }

                                // if (value.length < 5 || value.length > 20) {
                                //   return 'Password must be betweem 5 and 20 characters';
                                // }

                                return null;
                              },
                              // key: ValueKey('password'),
                              obscureText: _isHidden,
                              style: bodyText2White60,
                              keyboardType: TextInputType.visiblePassword,
                              // onSaved: (value) {
                              //       updatepPassword(context, value!, ref);
                              //   _pass = value;
                              // },
                              onChanged: (value) {
                                //     updatepPassword(context, value, ref);
                                setState(() {
                                  _pass = value;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: bodyText2White,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' Forget Password ?',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = (() => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResetPass(
                                                            // email: FirebaseAuth
                                                            //     .instance
                                                            //     .currentUser!
                                                            //     .email!,
                                                            )))),
                                          style: bodyText2White.copyWith(
                                              color: blue))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            _space(30),
                            GestureDetector(
                              onTap: () => login(),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: blue,
                                ),
                                child: Center(
                                  child: Text("Sign In", style: button),
                                ),
                              ),
                            ),

                            _space(28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/Tata-Power.jpeg',
                                  height: 150,
                                  width: 200,
                                )
                                // const Expanded(
                                //   child: Divider(thickness: 2, height: 1),
                                // ),
                                // Text("   OR   ", style: subtitle2black),
                                // const Expanded(
                                //   child: Divider(thickness: 2, height: 1),
                                // ),
                              ],
                            ),
                            _space(28),
                            // InkWell(
                            //   onTap: () {
                            //     _googleLogin(context, authService);
                            //   },
                            //   child: Container(
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(6),
                            //       color: darkGrey,
                            //     ),
                            //     child: Center(
                            //       child: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           SvgPicture.string(
                            //             '<svg xmlns="http://www.w3.org/2000/svg" width="19.6" height="20" viewBox="0 0 19.6 20"><defs></defs><path class="a" d="M3.064,7.51A10,10,0,0,1,12,2a9.6,9.6,0,0,1,6.69,2.6L15.823,7.473A5.4,5.4,0,0,0,12,5.977,6.007,6.007,0,0,0,6.405,13.9a6.031,6.031,0,0,0,8.981,3.168,4.6,4.6,0,0,0,2-3.018H12V10.182h9.418a11.5,11.5,0,0,1,.182,2.045,9.747,9.747,0,0,1-2.982,7.35A9.542,9.542,0,0,1,12,22,10,10,0,0,1,3.064,7.51Z" transform="translate(-2 -2)"/></svg>',
                            //             color: almostWhite,
                            //           ),
                            //           Text("  Continue with google",
                            //               style: button),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            _space(38),
                            // RichText(
                            //   text: TextSpan(
                            //     style: bodyText2White,
                            //     children: <TextSpan>[
                            //       TextSpan(
                            //           text: 'Dont have Account ? ',
                            //           style:
                            //               bodyText1white.copyWith(color: black)),
                            //       TextSpan(
                            //           text: ' Register Here',
                            //           recognizer: TapGestureRecognizer()
                            //             ..onTap = (() => Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       RegisterPage(),
                            //                 ))),
                            //           style: bodyText2White.copyWith(color: blue))
                            //     ],
                            //   ),
                            // ),
                            _space(38),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }

  login() async {
    if (_formkey.currentState!.validate()) {
      showCupertinoDialog(
        context: context,
        builder: (context) => const CupertinoAlertDialog(
          content: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('Admin')
          .where('Employee Id', isEqualTo: _id)
          .get();

      try {
        if (_pass == snap.docs[0]['Password'] &&
            _id == snap.docs[0]['Employee Id']) {
          _sharedPreferences = await SharedPreferences.getInstance();
          _sharedPreferences.setString('employeeId', _id).then((_) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SmallScreen(),
                ));
          });
          // ignore: use_build_context_synchronously

        } else {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password is not correct')));
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        String error = '';
        if (e.toString() ==
            'RangeError (index): Invalid value: Valid value range is empty: 0') {
          setState(() {
            error = 'Employee Id does not exist!';
          });
        } else {
          setState(() {
            error = 'Error occured!';
          });
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: blue,
        ));
      }
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
