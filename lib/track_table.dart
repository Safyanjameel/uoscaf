import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class TrackTableScreen extends StatefulWidget {
  final Map<String, dynamic> selectedTable; // Add selectedTable parameter

  TrackTableScreen({required this.selectedTable}); // Constructor with selectedTable parameter

  @override
  _TrackTableScreenState createState() => _TrackTableScreenState();
}

class _TrackTableScreenState extends State<TrackTableScreen> {
  Timer? _timer;
  int _remainingSeconds = 1800; // 30 minutes * 60 seconds

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (_) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    final String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void leaveTable() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()), // Navigate to the main.dart
    );
  }


  Future<bool> _onWillPop() async {
    return false; // Prevent back button press
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the selected table details
    final selectedTableNumber = widget.selectedTable['tableNumber'];
    final selectedTableRating = widget.selectedTable['tableRating'];

    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button press
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back arrow
          title: Center(
            child: Text(
              'Track Table',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF01115E),
          toolbarHeight: 100,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/uclogo.svg',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 40),
                Text(
                  'Table $selectedTableNumber Booked for 30 Minutes', // Display the selected table number
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Please have your meal within 30 minutes',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Text(
                  'Remaining Time',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  formatTime(_remainingSeconds),
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: leaveTable,
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF01115E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8,
                      shadowColor: Colors.yellow.withOpacity(0.2),
                    ),
                    child: Text(
                      'Leave Table',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
