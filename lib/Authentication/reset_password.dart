import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/Authentication/check_email.dart';
import 'package:web_appllication/style.dart';

class ResetPass extends StatefulWidget {
  // final String email;
  ResetPass({
    Key? key,
    // required this.email,
  }) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  FocusNode? _focusNode;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode!.addListener(_onOnFocusNodeEvent);
    // if (RegExp(
    //         r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
    //     .hasMatch(textEditingController.text)) ;
    // textEditingController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Reset Password',
      //     style: TextStyle(color: black),
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: const Icon(
      //       CupertinoIcons.back,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reset Password', style: headline5White),
              const SizedBox(height: 20),
              Text(
                'Enter the email associated with your account and we\'ll send an email with instructions to reset your password',
                style: bodyText2White60,
              ),
              const SizedBox(height: 80),
              TextField(
                controller: textEditingController,
                focusNode: _focusNode,
                style: bodyText2White38,
                decoration: InputDecoration(
                    fillColor: _focusNode!.hasFocus ? Colors.white : white,
                    filled: true,
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: almostblack,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    labelText: _focusNode!.hasFocus ? 'Email ID' : null,
                    labelStyle: _focusNode!.hasFocus ? bodyText2 : null,
                    hintText: _focusNode!.hasFocus ? null : 'Email ID',
                    hintStyle: bodyText2White38),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      minimumSize: MediaQuery.of(context).size,
                      backgroundColor: blue,
                    ),
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckEmail(
                                      email: textEditingController.text,
                                    )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Email is required'),
                        ));
                      }
                    },
                    child: Text('Send',
                        style: TextStyle(
                            fontSize: 14,
                            color: almostWhite,
                            fontWeight: FontWeight.w500))),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }
}
