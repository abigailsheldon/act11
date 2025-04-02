// Import Flutter packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InventoryApp());
}

class InventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InventoryHomePage(title: 'Inventory Home Page'),
    );
  }
}

class InventoryHomePage extends StatefulWidget {
  InventoryHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  // TODO: Implement Firestore integration
  
  // Function to display a dialog for adding a new inventory item
  void _showAddItemDialog() {
  String name = '';         // Initialized with an empty string
  String quantityStr = '';  // Initialized with an empty string
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Item Name'),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                quantityStr = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name.isNotEmpty && quantityStr.isNotEmpty) {
                int quantity = int.tryParse(quantityStr) ?? 0;
                // Create operation
                FirebaseFirestore.instance.collection('items').add({
                  'name': name,
                  'quantity': quantity,
                });
              }
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Inventory Management System'),
            // TODO: Implement inventory list view
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add inventory item
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}
