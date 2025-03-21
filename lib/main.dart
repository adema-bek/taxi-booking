import 'package:flutter/material.dart';
import 'pages/trip_cost_page.dart';
import 'pages/drivers_page.dart';
import 'pages/create_order_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride Booking App',
      initialRoute: '/',
      routes: {
        '/': (context) => TripCostPage(),
        '/drivers': (context) => DriversPage(),
        '/create-order': (context) => CreateOrderPage(),
      },
    );
  }
}
