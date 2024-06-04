import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'email_verification.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  bool _isPasswordVisible = false;

  void _signUp(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Mismatch!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
            content: Text('The passwords entered do not match.',style: GoogleFonts.poppins(fontSize: 14)),
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
      return;
    }

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EmailVerificationPage(email)),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Up Failed!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
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
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
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
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password', labelStyle: GoogleFonts.poppins(),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 20.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password', labelStyle: GoogleFonts.poppins(),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 20.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins( fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => _signUp(context),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF01115E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () => _navigateToLogin(context),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB29222)
                                ),
                              ),
                            ],
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
