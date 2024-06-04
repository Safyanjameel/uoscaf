import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uoscaf/Student/payment.dart';
import 'package:uoscaf/Student/payment_receipt.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  final double totalPrice;

  OrderConfirmationScreen({required this.orderId, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pending,
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'After payment a table will book for 30 minutes',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Order ID: $orderId',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Total Price: ₨ ${totalPrice.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      orderId: orderId,
                      totalAmount: totalPrice,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF01115E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 8,
                shadowColor: Colors.yellow.withOpacity(0.2),
              ),
              child: Text(
                'Pay ₨ ${totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
