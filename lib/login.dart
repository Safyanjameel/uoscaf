import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password.dart';
import 'signup.dart';
import 'account_selection.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _signIn(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AccountSelection(username: email)),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Email Not Verified!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
                content: Text('Please verify your email before logging in.',style: GoogleFonts.poppins(fontSize: 14)),
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
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Password!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
            content: Text('Please enter a valid password.',style: GoogleFonts.poppins(fontSize: 14)),
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

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SignupPage()),
    );
  }

  void _navigateToForgotPassword(BuildContext context) {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ForgotPasswordPage(email)),
      );
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
          'Login',
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
                    SvgPicture.asset(
                      'assets/uclogo1.svg',
                      height: 250.0,
                    ),
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
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password', labelStyle: GoogleFonts.poppins(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(
                              color: Color(0xFFB29222),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            _navigateToForgotPassword(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.only(bottom: 0.0),
              child: ElevatedButton(
                child: Text(
                  'Log in',
                  style: GoogleFonts.poppins( fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  _signIn(context);
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
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account?',
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
                TextButton(
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    _navigateToSignUp(context);
                  },
                  style: TextButton.styleFrom(
                    primary: const Color(0xFFB29222),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
