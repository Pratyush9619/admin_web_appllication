import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/style.dart';

class CheckEmail extends StatefulWidget {
  final String email;
  const CheckEmail({Key? key, required this.email}) : super(key: key);

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            //         SvgPicture.asset('Assets/icon/yt.svg', width: 128, height: 128),
            const SizedBox(height: 20),
            SizedBox(
              width: 265,
              child: Text('Check your email',
                  style: TextStyle(color: almostblack, fontSize: 25),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 282,
              child: Text(
                  'We have sent an email to ${widget.email} with a link to get back into your account ',
                  style: TextStyle(color: white60, fontSize: 14),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    minimumSize: MediaQuery.of(context).size,
                    backgroundColor: blue,
                  ),
                  onPressed: () async {
                    await LaunchApp.openApp(
                        androidPackageName: 'com.google.android.gm');
                  },
                  child: Text('Open Email App', style: subtitle2black)),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text('Skip, I\'ll confirm later',
                  style: subtitle2black, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 70),
            Text('Did not receive the mail? Check your spam folder',
                style: bodyText2White60, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('or ', style: TextStyle(color: white60, fontSize: 14)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('try another email address',
                      style: TextStyle(color: blue, fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
