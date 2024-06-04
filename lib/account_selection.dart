import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Admin/admin_credential.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Student/orderfood.dart';

class AccountSelection extends StatefulWidget {
  final String username;

  AccountSelection({required this.username});

  @override
  _AccountSelectionState createState() => _AccountSelectionState();
}

class _AccountSelectionState extends State<AccountSelection> {
  double adminContainerHeight = 100.0;
  double studentContainerHeight = 100.0;
  bool adminVisible = true;
  bool studentVisible = true;

  void navigateToAdminCredential() {
    setState(() {
      adminVisible = false;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminCredential()),
      ).then((value) {
        // Reset the button heights and visibility when returning from AdminCredential screen
        setState(() {
          adminContainerHeight = 100.0;
          adminVisible = true;
        });
      });
    });
  }

  void navigateToMenu() {
    setState(() {
      studentVisible = false;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderFoodScreen()),
      ).then((value) {
        // Reset the button heights and visibility when returning from Menu screen
        setState(() {
          studentContainerHeight = 100.0;
          studentVisible = true;
        });
      });
    });
  }

  void _logOut() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Selection',
          style: GoogleFonts.poppins(fontSize: 28, color: Colors.white,fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      const Color(0xFF01115E),
                      const Color(0xFFB29222),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/uclogo.svg',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 0),
                    Text(
                      'Welcome',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.username,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Please swipe down',
                  style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Draggable(
                      axis: Axis.vertical,
                      feedback: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFB29222),
                        ),
                        child: Center(
                          child: Opacity(
                            opacity: adminVisible ? 1.0 : 0.0,
                            child: Text(
                              'Admin',
                              style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: adminVisible ? 1.0 : 0.0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 120,
                          height: adminContainerHeight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF01115E),
                          ),
                          child: Center(
                            child: Text(
                              'Admin',
                              style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      onDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy > 0) {
                          // Swiped down
                          setState(() {
                            adminContainerHeight = 0.0;
                          });
                          navigateToAdminCredential();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: Draggable(
                      axis: Axis.vertical,
                      feedback: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF01115E),
                        ),
                        child: Center(
                          child: Opacity(
                            opacity: studentVisible ? 1.0 : 0.0,
                            child: Text(
                              'Student',
                              style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: studentVisible ? 1.0 : 0.0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 120,
                          height: studentContainerHeight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFB29222),
                          ),
                          child: Center(
                            child: Text(
                              'Student',
                              style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      onDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy > 0) {
                          // Swiped down
                          setState(() {
                            studentContainerHeight = 0.0;
                          });
                          navigateToMenu();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox.fromSize(size: Size.fromHeight(150.0),),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    'Log out',
                    style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
                  ),
                  onPressed: () => _logOut(),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF01115E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
