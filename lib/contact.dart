import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact',
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
          DepartmentContact(
            department: 'IT Department',
            email: 'it_department@example.com',
            phoneNumber: '123-456-7890',
          ),
          DepartmentContact(
            department: 'CS Department',
            email: 'cs_department@example.com',
            phoneNumber: '987-654-3210',
          ),
          DepartmentContact(
            department: 'SE Department',
            email: 'se_department@example.com',
            phoneNumber: '456-789-0123',
          ),
          DepartmentContact(
            department: 'Cafeteria',
            email: 'cafeteria@example.com',
            phoneNumber: '789-012-3456',
          ),
          // Add more DepartmentContact widgets for other departments
        ],
      ),
    );
  }
}

class DepartmentContact extends StatelessWidget {
  final String department;
  final String email;
  final String phoneNumber;

  const DepartmentContact({
    required this.department,
    required this.email,
    required this.phoneNumber,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            department,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Email: $email',
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 4),
          Text(
            'Phone: $phoneNumber',
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }
}
