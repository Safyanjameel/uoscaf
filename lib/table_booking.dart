import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uoscaf/track_table.dart';

class TableBookingScreen extends StatefulWidget {
  @override
  _TableBookingScreenState createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  int selectedTableNumber = 0;

  List<Map<String, dynamic>> tables = [
    {'tableNumber': 1, 'tableRating': 4, 'isTableAvailable': true, 'isLastFourTables': false},
    {'tableNumber': 2, 'tableRating': 2, 'isTableAvailable': true, 'isLastFourTables': false},
    {'tableNumber': 3, 'tableRating': 6, 'isTableAvailable': false, 'isLastFourTables': false},
    {'tableNumber': 4, 'tableRating': 3, 'isTableAvailable': true, 'isLastFourTables': false},
    {'tableNumber': 5, 'tableRating': 2, 'isTableAvailable': true, 'isLastFourTables': true},
    {'tableNumber': 6, 'tableRating': 4, 'isTableAvailable': false, 'isLastFourTables': true},
    {'tableNumber': 7, 'tableRating': 4, 'isTableAvailable': true, 'isLastFourTables': false},
    {'tableNumber': 8, 'tableRating': 2, 'isTableAvailable': true, 'isLastFourTables': false},
    {'tableNumber': 9, 'tableRating': 6, 'isTableAvailable': false, 'isLastFourTables': false},
    {'tableNumber': 10, 'tableRating': 3, 'isTableAvailable': true, 'isLastFourTables': false},
    {'tableNumber': 11, 'tableRating': 2, 'isTableAvailable': true, 'isLastFourTables': true},
    {'tableNumber': 12, 'tableRating': 4, 'isTableAvailable': false, 'isLastFourTables': true},
    // Add more tables as needed
  ];

  void selectTable(int tableNumber) {
    setState(() {
      selectedTableNumber = tableNumber;
    });
  }

  void navigateToTrackTable() {
    if (selectedTableNumber > 0) {
      final selectedTable = tables.firstWhere((table) => table['tableNumber'] == selectedTableNumber);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackTableScreen(selectedTable: selectedTable),
        ),
      );
    } else {
      // Show an error message or prompt to select a table
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Table Booking',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select a Table',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  final table = tables[index];
                  final tableNumber = table['tableNumber'];
                  final tableRating = table['tableRating'];
                  final isTableAvailable = table['isTableAvailable'];
                  final isLastFourTables = table['isLastFourTables'];

                  // Calculate the opacity based on the table availability
                  final opacity = isTableAvailable ? 1.0 : 0.5;

                  return GestureDetector(
                    onTap: () {
                      if (isTableAvailable) {
                        selectTable(tableNumber);
                      }
                    },
                    child: IgnorePointer(
                      ignoring: !isTableAvailable, // Make the booked tables unclickable
                      child: Opacity(
                        opacity: opacity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: selectedTableNumber == tableNumber ? Colors.blue : Colors.white,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    isTableAvailable ? Icons.check_circle : Icons.remove_circle,
                                    size: 64,
                                    color: selectedTableNumber == tableNumber ? Colors.white : Colors.black,
                                  ),
                                  Text(
                                    'Table $tableNumber',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: selectedTableNumber == tableNumber ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.event_seat,
                                        color: Colors.orangeAccent,
                                        size: 18,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        '$tableRating Seats',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: selectedTableNumber == tableNumber ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (isLastFourTables)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      'Special',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
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
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToTrackTable,
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF01115E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 8,
                shadowColor: Colors.yellow.withOpacity(0.2),
              ),
              child: Container(
                width: double.infinity, // Set the width to expand to the available space
                child: Center(
                  child: Text(
                    'Book Selected Table',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
