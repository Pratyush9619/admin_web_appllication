import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:web_appllication/Authentication/auth_service.dart';
import 'package:web_appllication/Authentication/login_register.dart';
import 'package:web_appllication/main.dart';
import 'package:web_appllication/small_screen.dart';
import 'package:web_appllication/style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? password;
  String? confpassword;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: const AppBarWithBack(
        //   text: "",
        // ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              reverse: false,
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
                            labelText: "First Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Display First Name is required';
                            }

                            return null;
                          },

                          // key: ValueKey('username'),
                          keyboardType: TextInputType.name,
                          style: bodyText2White60,
                          // onSaved: (value) {
                          //   _name = value!;
                          // },
                          onChanged: (value) {
                            setState(() {
                              firstname = value;
                            });
                          }),

                      const SizedBox(height: 24),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: "Last Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Display Last Name is required';
                            }

                            return null;
                          },

                          // key: ValueKey('username'),
                          keyboardType: TextInputType.name,
                          style: bodyText2White60,
                          // onSaved: (value) {
                          //   _name = value!;
                          // },
                          onChanged: (value) {
                            setState(() {
                              lastname = value;
                            });
                          }),
                      const SizedBox(height: 24),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (value) {
                          print(value.completeNumber);
                          phone = value.completeNumber.toString();
                        },
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 0,
                      //       child: CountryPickerDropdown(
                      //         initialValue: 'in',
                      //         itemBuilder: _buildDropdownItem,
                      //         onValuePicked: (Country country) {
                      //           print("${country.name}");
                      //           value = country.phoneCode.toString();
                      //         },
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: TextFormField(
                      //           textInputAction: TextInputAction.next,
                      //           decoration: const InputDecoration(
                      //             labelText: "Phone",
                      //           ),
                      //           validator: (value) {
                      //             if (value!.isEmpty) {
                      //               return 'Display Number is required';
                      //             }

                      //             if (value.length < 10) {
                      //               return '10 digit number is required';
                      //             }

                      //             return null;
                      //           },

                      //           // key: ValueKey('username'),
                      //           keyboardType: TextInputType.number,
                      //           style: bodyText2White60,
                      //           // onSaved: (value) {
                      //           //   _name = value!;
                      //           // },
                      //           onChanged: (value) {
                      //             setState(() {
                      //               phone = value;
                      //             });
                      //           }),
                      //     ),
                      //   ],
                      // ),

                      const SizedBox(height: 24),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: "Email ID",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }

                            if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          },
                          style: bodyText2White60,
                          keyboardType: TextInputType.emailAddress,
                          // onSaved: (value) {
                          //   setState(() {
                          //     _email = value!;
                          //   });
                          // },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          }),
                      const SizedBox(height: 24),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: "Designation",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Designation is required';
                            }

                            return null;
                          },

                          // key: ValueKey('username'),
                          keyboardType: TextInputType.name,
                          style: bodyText2White60,
                          // onSaved: (value) {
                          //   _name = value!;
                          // },
                          onChanged: (value) {
                            setState(() {
                              designation = value;
                            });
                          }),
                      const SizedBox(height: 24),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: "Department",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Department is required';
                            }

                            return null;
                          },
                          // key: ValueKey('username'),
                          keyboardType: TextInputType.name,
                          style: bodyText2White60,
                          // onSaved: (value) {
                          //   _name = value!;
                          // },
                          onChanged: (value) {
                            setState(() {
                              department = value;
                            });
                          }),
                      const SizedBox(height: 24),
                      TextFormField(
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: _isHidden
                                  ? const Icon(Icons.visibility)
                                  : Icon(
                                      Icons.visibility_off,
                                      color: grey,
                                    )),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'Password should be 8 caharecter & contain alphabate , numbers & special character';
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
                        //   setState(() {
                        //     _pass = value!;
                        //   });
                        // },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (value != password) {
                            return 'Confirm Password not matched with password';
                          }

                          // if (value.length < 5 || value.length > 20) {
                          //   return 'Confirm Password must be betweem 5 and 20 characters';
                          // }

                          return null;
                        },
                        // key: ValueKey('password'),
                        obscureText: true,
                        style: bodyText2White60,
                        keyboardType: TextInputType.visiblePassword,
                        // onSaved: (value) {
                        //   setState(() {
                        //     _pass = value!;
                        //   });
                        // },
                        onChanged: (value) {
                          setState(() {
                            confpassword = value;
                          });
                        },
                      ),
                      const SizedBox(height: 38),
                      GestureDetector(
                        onTap: () {
                          register();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: blue,
                          ),
                          child: Center(
                            child: Text("Register", style: button),
                          ),
                        ),
                      ),
                      //  _space(28),
                      // Row(
                      //   children: [
                      //     const Expanded(
                      //       child: Divider(thickness: 2, height: 1),
                      //     ),
                      //     Text("   OR   ", style: subtitle2black),
                      //     const Expanded(
                      //       child: Divider(thickness: 2, height: 1),
                      //     ),
                      //   ],
                      // ),
                      _space(28),
                      // InkWell(
                      //   onTap: () => _googleLogin(context, authService),
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
                      _space(5),
                      Center(
                        child: Image.asset(
                          'assets/Tata-Power.jpeg',
                          height: 150,
                          width: 200,
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     style: bodyText2White,
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //           text: 'Already a user ? ',
                      //           style: bodyText1white.copyWith(color: black)),
                      //       TextSpan(
                      //           text: ' SignIn here',
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = (() => Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const SignInPage(),
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
          ),
        ],
      ),
    ));
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }

  void register() async {
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
      await authService
          .registerUserWithEmailAndPassword(firstname!, lastname!, phone!,
              email!, designation!, department!, password!, confpassword!)
          .then((value) {
        if (value == true) {
          authService
              .storeDataInFirestore(
                  firstname!,
                  lastname!,
                  phone!,
                  email!,
                  designation!,
                  department!,
                  password!,
                  confpassword!,
                  firstname![0] + lastname![0] + phone!.substring(9, 13))
              .then((value) {
            if (value == true) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Registration Successfully Please Sign In'),
                backgroundColor: blue,
              ));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginRegister()),
              );
            } else {
              Navigator.pop(context);
              //     authService.firebaseauth.signOut();
            }
          });
        } else {
          Navigator.of(context).pop();
        }
      });
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
}
