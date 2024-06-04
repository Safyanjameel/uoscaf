import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
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
          DepartmentInfo(
            department: 'IT Department',
            registrationLink: 'https://admission.uosahiwal.edu.pk/',
            prospectusLink: 'https://www.uosahiwal.edu.pk/prospectus',
          ),
          DepartmentInfo(
            department: 'Chemistry Department',
            registrationLink: 'https://admission.uosahiwal.edu.pk/',
            prospectusLink: 'https://www.uosahiwal.edu.pk/prospectus',
          ),
          DepartmentInfo(
            department: 'CS Department',
            registrationLink: 'https://admission.uosahiwal.edu.pk/',
            prospectusLink: 'https://www.uosahiwal.edu.pk/prospectus',
          ),
          DepartmentInfo(
            department: 'SE Department',
            registrationLink: 'https://admission.uosahiwal.edu.pk/',
            prospectusLink: 'https://www.uosahiwal.edu.pk/prospectus',
          ),
          // Add more DepartmentInfo widgets for other departments
        ],
      ),
    );
  }
}

class DepartmentInfo extends StatelessWidget {
  final String department;
  final String registrationLink;
  final String prospectusLink;

  const DepartmentInfo({
    required this.department,
    required this.registrationLink,
    required this.prospectusLink,
  });

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
          ListTile(
            title: Text(
              'Online Registration',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Link: $registrationLink',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              _launchURL(registrationLink);
            },
          ),
          ListTile(
            title: Text(
              'Online Prospectus',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Link: $prospectusLink',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              _launchURL(prospectusLink);
            },
          ),
        ],
      ),
    );
  }
}
