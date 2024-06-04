import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uoscaf/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about.dart';
import 'contact.dart';
import 'firebase_options.dart';
import 'internet.dart';
import 'orderfood1.dart';
import 'splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      '/login': (context) => LoginPage(),
      '/orientation': (context) => InternetScreen(),
      '/contact': (context) => ContactScreen(),
      '/about': (context) => AboutScreen(),
      '/orderFood1': (context) => OrderFood1Screen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'UosCafe',
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: Column(
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
                  'Welcome to UosCafe!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Delicious food served with care\nEnjoy attentive table service.',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 40)),
          Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.pink[400]!, Colors.pink[800]!],
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(16),
            child: Text(
              'If you are a new student, you can use these services',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/orderFood1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: CircleBorder(),
                            minimumSize: const Size(80, 80),
                            elevation: 8,
                            shadowColor: Colors.yellow.withOpacity(0.4),
                          ),
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(Icons.no_meals),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/about');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFB01EFF),
                            shape: CircleBorder(),
                            minimumSize: const Size(80, 80),
                            elevation: 8,
                            shadowColor: Colors.yellow.withOpacity(0.4),
                          ),
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(Icons.school),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/contact');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: CircleBorder(),
                            minimumSize: const Size(80, 80),
                            elevation: 8,
                            shadowColor: Colors.yellow.withOpacity(0.4),
                          ),
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(Icons.phone),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/orientation');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: CircleBorder(),
                            minimumSize: const Size(80, 80),
                            elevation: 8,
                            shadowColor: Colors.yellow.withOpacity(0.4),
                          ),
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(Icons.compass_calibration),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 56,
                    margin: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF01115E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 8,
                        shadowColor: Colors.yellow.withOpacity(0.4),
                      ),
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
