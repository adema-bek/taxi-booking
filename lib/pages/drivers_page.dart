import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriversPage extends StatefulWidget {
  @override
  _DriversPageState createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  List<dynamic> drivers = [];
  bool isLoading = false;

  Future<void> fetchDrivers() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse('https://your-api-url.com/nearby-drivers');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        drivers = data['drivers'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to fetch drivers")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Drivers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: fetchDrivers,
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Find Drivers'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(drivers[index]['name']),
                      subtitle: Text('${drivers[index]['distance']} km away'),
                      trailing: Icon(Icons.directions_car),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/create-order'),
              child: Text('Create Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
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
