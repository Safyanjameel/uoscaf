import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wi-Fi Connections',
          style: GoogleFonts.poppins(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: ListView(
        children: [
          DepartmentWiFiList(
            department: 'Cafeteria',
            wifiConnections: [
              WiFiConnection(name: 'Cafeteria WiFi', password: 'password9'),
            ],
          ),
          DepartmentWiFiList(
            department: 'IT Department',
            wifiConnections: [
              WiFiConnection(name: 'IT_WiFi1', password: 'password1'),
              WiFiConnection(name: 'IT_WiFi2', password: 'password2'),
              WiFiConnection(name: 'IT_WiFi3', password: 'password3'),
            ],
          ),
          DepartmentWiFiList(
            department: 'CS Department',
            wifiConnections: [
              WiFiConnection(name: 'CS_WiFi1', password: 'password4'),
              WiFiConnection(name: 'CS_WiFi2', password: 'password5'),
            ],
          ),
          DepartmentWiFiList(
            department: 'SE Department',
            wifiConnections: [
              WiFiConnection(name: 'SE_WiFi1', password: 'password6'),
              WiFiConnection(name: 'SE_WiFi2', password: 'password7'),
              WiFiConnection(name: 'SE_WiFi3', password: 'password8'),
            ],
          ),
          // Add more DepartmentWiFiList widgets for other departments
        ],
      ),
    );
  }
}

class DepartmentWiFiList extends StatelessWidget {
  final String department;
  final List<WiFiConnection> wifiConnections;

  const DepartmentWiFiList({
    required this.department,
    required this.wifiConnections,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFB29222),
            padding: const EdgeInsets.all(16),
            child: Text(
              department,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: wifiConnections.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ListTile(
                  title: Text(
                    wifiConnections[index].name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Password: ${wifiConnections[index].password}',
                    style: GoogleFonts.poppins(),
                  ),
                  onTap: () {
                    // Connect to Wi-Fi logic
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WiFiConnection {
  final String name;
  final String password;

  WiFiConnection({
    required this.name,
    required this.password,
  });
}
