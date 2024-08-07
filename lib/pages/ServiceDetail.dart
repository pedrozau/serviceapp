import 'package:flutter/material.dart';
import 'package:myapp/model.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Service service;

  ServiceDetailScreen({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              service.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              service.description,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Price: \$${service.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement the contract service logic here if needed
              },
              child: Text('Contract Service'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, // Button text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
