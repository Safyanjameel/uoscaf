import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCredential extends StatefulWidget {
  @override
  _AdminCredentialState createState() => _AdminCredentialState();
}

class _AdminCredentialState extends State<AdminCredential> {
  final TextEditingController adminCredentialController = TextEditingController();
  bool _isCredentialVisible = false;

  List<String> adminCredentials = [
    "Junaid@BSIT4",
    "Sharoon@BSIT52",
    "Safyan@BSIT49",
    "Qasim@BSIT50",
    "Mohsin@BSIT24"
  ];

  void _proceedToAdminPanel(BuildContext context) {
    String enteredCredential = adminCredentialController.text.trim();

    if (adminCredentials.contains(enteredCredential)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AdminScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credential!',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Please enter a valid admin credential.',style: GoogleFonts.poppins(fontSize: 14)),
                SizedBox(height: 16.0),
                Text(
                  'If you don\'t know the credentials, please contact the owner:',style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFFB29222))
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Color(0xFF01115E),
                            Color(0xFFB29222),
                          ],
                          stops: [0.2, 0.8],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text('+923125162976',style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.center,
                          radius: 0.7,
                          colors: [
                            Color(0xFF01115E),
                            Color(0xFFB29222),
                          ],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text('junaidrao7776@gmail.com',style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
              ],
            ),
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
          'Admin Credential',
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
                      child: TextFormField(
                        controller: adminCredentialController,
                        obscureText: !_isCredentialVisible,
                        decoration: InputDecoration(
                          labelText: 'Admin Credential', labelStyle: GoogleFonts.poppins(),
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
                                _isCredentialVisible = !_isCredentialVisible;
                              });
                            },
                            child: Icon(
                              _isCredentialVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
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
                  'Proceed',
                  style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  _proceedToAdminPanel(context);
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
          ],
        ),
      ),
    );
  }
}
