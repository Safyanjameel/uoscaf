import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Admin/admin_screen.dart';
import 'order_confirmation.dart';

class OrderFoodScreen extends StatefulWidget {
  @override
  _OrderFoodScreenState createState() => _OrderFoodScreenState();
}

class _OrderFoodScreenState extends State<OrderFoodScreen> {
  CollectionReference _menuItemsCollection =
  FirebaseFirestore.instance.collection('menu_items');

  List<MenuItem> _menuItems = [];
  List<MenuItem> _selectedItems = [];
  bool _isAdmin = false; // Track admin status

  @override
  void initState() {
    super.initState();
    _fetchMenuItems();
  }

  void _fetchMenuItems() async {
    QuerySnapshot snapshot = await _menuItemsCollection.get();
    List<MenuItem> menuItems = [];
    snapshot.docs.forEach((doc) {
      MenuItem menuItem = MenuItem.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      menuItems.add(menuItem);
    });
    setState(() {
      _menuItems = menuItems;
    });
  }

  void _deleteMenuItem(MenuItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this menu item?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _menuItemsCollection
                    .doc(item.id)
                    .delete()
                    .then((_) {
                  setState(() {
                    _menuItems.remove(item);
                    _selectedItems.remove(item);
                  });
                  Navigator.pop(context);
                })
                    .catchError((error) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Failed to delete menu item.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _selectItem(MenuItem item) {
    setState(() {
      _selectedItems.add(item);
    });
  }

  void _deselectItem(MenuItem item) {
    setState(() {
      _selectedItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Food',
          style: GoogleFonts.poppins(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF01115E),
        toolbarHeight: 100,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  MenuItem item = _menuItems[index];
                  return ListTile(
                    title: Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '${item.category} - Rs ${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    trailing: _isAdmin
                        ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteMenuItem(item);
                      },
                    )
                        : IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _selectItem(item);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Selected Items:',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedItems.length,
                itemBuilder: (context, index) {
                  MenuItem item = _selectedItems[index];
                  return ListTile(
                    title: Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '${item.category} - Rs ${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _deselectItem(item);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF01115E),
              ),
              onPressed: _selectedItems.isNotEmpty
                  ? _isAdmin
                  ? _openAdminScreen // Navigate to the admin screen
                  : _placeOrder
                  : null,
              child: Text(
                'Place Order',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAdminScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminScreen()),
    ).then((_) {
      // Refresh the menu items after returning from admin screen
      _fetchMenuItems();
    });
  }

  void _placeOrder() {

    // Prepare the order details
    String orderDetails = '';
    double totalAmount = 0.0;
    for (int i = 0; i < _selectedItems.length; i++) {
      MenuItem item = _selectedItems[i];
      orderDetails += '${item.name} - Rs ${item.price.toStringAsFixed(2)}\n';
      totalAmount += item.price;
    }

    // Display the order details and ask for confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order Details:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(orderDetails),
              SizedBox(height: 16.0),
              Text(
                'Total Amount: Rs ${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _performOrderPlacement(orderDetails, totalAmount);
              },
            ),
          ],
        );
      },
    );
  }

  void _performOrderPlacement(String orderDetails, double totalAmount) {
    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Placing Order'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );

    // Add order details to Firestore
    FirebaseFirestore.instance
        .collection('orders')
        .add({
      'orderDetails': orderDetails,
      'totalAmount': totalAmount,
    })
        .then((value) {
      // Order placement successful
      Navigator.pop(context); // Close the loading dialog

      // Navigate to the order confirmation screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            orderId: value.id,
            totalPrice: totalAmount,
          ),
        ),
      );
    })
        .catchError((error) {
      // Error occurred while placing the order
      Navigator.pop(context); // Close the loading dialog

      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Order Placement Error'),
            content: Text('An error occurred while placing the order.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    });
  }
}

class MenuItem {
  final String id;
  final String name;
  final String category;
  final double price;

  MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map, String id) {
    return MenuItem(
      id: id,
      name: map['name'],
      category: map['category'],
      price: map['price'].toDouble(),
    );
  }
}
