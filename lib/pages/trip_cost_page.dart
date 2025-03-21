import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TripCostPage extends StatefulWidget {
  @override
  _TripCostPageState createState() => _TripCostPageState();
}

class _TripCostPageState extends State<TripCostPage> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GoogleMapController? mapController;

  // Sample coordinates for Pickup and Destination
  LatLng pickupLocation = LatLng(40.7128, -74.0060);  // Example: New York
  LatLng destinationLocation = LatLng(40.730610, -73.935242);  // Example: Manhattan

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _getPolyline();
  }

  // Set markers for pickup and destination
  void _setMarkers() {
    _markers.add(Marker(
      markerId: MarkerId('pickup'),
      position: pickupLocation,
      infoWindow: InfoWindow(title: 'Pickup Location'),
    ));
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position: destinationLocation,
      infoWindow: InfoWindow(title: 'Destination'),
    ));
  }

  // Get Polyline for directions
  Future<void> _getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'YOUR_GOOGLE_MAPS_API_KEY', // Replace with your actual API key
      PointLatLng(pickupLocation.latitude, pickupLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Cost Calculator'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: pickupLocation,
              zoom: 12.0,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              mapController = controller;
            },
          ),
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: pickupController,
                      decoration: InputDecoration(
                        labelText: 'Pickup Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: destinationController,
                      decoration: InputDecoration(
                        labelText: 'Destination',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Choose Vehicle'),
                    Column(
                      children: [
                        ListTile(
                          title: Text('City Bus'),
                          trailing: Text('\$5.75'),
                          subtitle: Text('3-5 min - 18 km away'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Micro Bus'),
                          trailing: Text('\$3.75'),
                          subtitle: Text('3-6 min - 13 km away'),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text('Payment Method:'),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Credit Card',
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Book Ride'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
