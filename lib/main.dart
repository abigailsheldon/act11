// Import Flutter packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Debug
  print('Firebase Initialized Successfully');

  runApp(InventoryApp());
}

class InventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Jacquard12',
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
          
          // Cancel button on pop-up
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

// Function to display a dialog for updating an existing inventory item (Update)
  void _showUpdateItemDialog(String id, String currentName, int currentQuantity) {
    String updatedName = currentName;
    String updatedQuantityStr = currentQuantity.toString();
    
    // Create controllers so that the text fields are pre-populated.
    TextEditingController nameController = TextEditingController(text: currentName);
    TextEditingController quantityController = TextEditingController(text: currentQuantity.toString());
    
    showDialog(
      context: context,
      builder: (context) {
        
        return AlertDialog(
          
          title: Text('Update Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
                onChanged: (value) {
                  updatedName = value;
                },
              ),
              
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  updatedQuantityStr = value;
                },
              ),
            ],
          ),
          actions: [
            
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            
            TextButton(
              onPressed: () {
                int updatedQuantity = int.tryParse(updatedQuantityStr) ?? currentQuantity;
                
                // Update operation
                FirebaseFirestore.instance.collection('items').doc(id).update({
                  'name': updatedName,
                  'quantity': updatedQuantity,
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
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
      body: StreamBuilder<QuerySnapshot>(
        
        /* Retrieve */
        // Grab inventory items
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          
        
          // Build a list of inventory items
          // snapshot.data guaranteed to be non-null
          final items = snapshot.data!.docs;
          
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final doc = items[index];
              final itemData = doc.data() as Map<String, dynamic>;
              final name = itemData['name'] ?? 'No Name';
              final quantity = itemData['quantity'] ?? 0;
              
              return ListTile(
                title: Text(name),
                subtitle: Text("Quantity: $quantity"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        
                        /* Update */
                        // Show dialog for updating item
                        _showUpdateItemDialog(doc.id, name, quantity);
                      },
                    ),
                    
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        
                        /* Delete */
                        // Remove item from Firestore
                        FirebaseFirestore.instance.collection('items').doc(doc.id).delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      
      /* Create */
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddItemDialog, // Add new inventory item
        tooltip: 'Create Item',
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create New Item'),
            SizedBox(width: 8),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}