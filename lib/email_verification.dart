import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class EmailVerificationPage extends StatelessWidget {
  final String email;

  EmailVerificationPage(this.email);

  void _sendEmailVerification(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.sendEmailVerification();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Verification Successful',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Your email $email is verified. Please go to the login screen for sign-in',style: GoogleFonts.poppins(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),

                  TextButton(
                    child: Text(
                      'Login',style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFFB29222))
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
              actions: <Widget>[],
            );
          },
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Failed to Send Verification Email',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              content: Text(error.toString()),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK',style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF01115E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email Verification',
          style: GoogleFonts.poppins(fontSize: 28, color: Colors.white,fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            Icon(
              Icons.email,
              size: 80.0,
              color: Color(0xFF01115E),
            ),
            SizedBox(height: 24.0),
            Text(
              'Please verify your email',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'An email will be sent to $email. Please click and open the verification link for registration.',style: GoogleFonts.poppins(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text(
                'Verify Email',
                style: GoogleFonts.poppins( fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              onPressed: () => _sendEmailVerification(context),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF01115E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
