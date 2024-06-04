import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
class ForgotPasswordPage extends StatefulWidget {
  final String email;

  const ForgotPasswordPage(this.email);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  void _sendPasswordResetEmail(BuildContext context) async {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Reset Email Sent!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
              content: Text(
                'A password reset email has been sent to $email. Please check your inbox and follow the instructions to reset your password.',style: GoogleFonts.poppins(fontSize: 14)
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xFF01115E)),
                  child: Text('OK',style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Reset Failed!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
              content: Text(error.toString()),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xFF01115E)),
                  child: Text('OK',style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Forgot Password?',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
            content: Text('Please enter your email to reset the password.',style: GoogleFonts.poppins(fontSize: 14)),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: const Color(0xFF01115E)),
                child: Text('OK',style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email', labelStyle: GoogleFonts.poppins(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.poppins( fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          _sendPasswordResetEmail(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF01115E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
