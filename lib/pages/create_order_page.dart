import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  bool isLoading = false;

  Future<void> createOrder() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse('https://your-api-url.com/create-order');
    var response = await http.post(url, body: {
      'pickup': 'Your Pickup Location',
      'destination': 'Your Destination',
      'cost': '100', // Example cost
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to create order")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Ride Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: createOrder,
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Confirm & Book Ride'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
