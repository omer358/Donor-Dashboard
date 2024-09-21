import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng? selectedLocation; // To store the selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر موقع المستشفى'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.7136, 46.6753), // Default to Riyadh
          zoom: 10,
        ),
        onTap: (LatLng location) {
          setState(() {
            selectedLocation = location; // Update selected location on tap
          });
        },
        markers: selectedLocation != null
            ? {
          Marker(
            markerId: const MarkerId('selected-location'),
            position: selectedLocation!,
          ),
        }
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedLocation != null) {
            Navigator.pop(context, selectedLocation); // Return the location
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
