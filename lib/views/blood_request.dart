import 'package:blood_donor_dashboard/views/select_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Add this import
import '../controllers/donation_controller.dart';
import '../models/blood_type.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({super.key});

  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  final DonationController donationController = Get.put(DonationController());
  final TextEditingController locationController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  BloodType? selectedBloodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة طلب دم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blood Type Dropdown
              DropdownButtonFormField<BloodType>(
                value: selectedBloodType,
                hint: const Text('إختر نوع الدم'),
                decoration: InputDecoration(
                  labelText: 'نوع الدم',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: BloodType.values.map((BloodType bloodType) {
                  return DropdownMenuItem<BloodType>(
                    value: bloodType,
                    child: Text(bloodType.displayName),
                  );
                }).toList(),
                onChanged: (BloodType? newValue) {
                  setState(() {
                    selectedBloodType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Location Input Field
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'الموقع',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Button to Select Location via Map
              ElevatedButton(
                onPressed: () async {
                  // Navigate to the SelectLocationScreen and wait for the result
                  final LatLng? selectedLocation = await Get.to(() => SelectLocationScreen());

                  if (selectedLocation != null) {
                    // Update latitude and longitude fields automatically
                    latitudeController.text = selectedLocation.latitude.toString();
                    longitudeController.text = selectedLocation.longitude.toString();
                  }
                },
                child: const Text('اختر موقع المستشفى على الخريطة'),
              ),
              const SizedBox(height: 16),
              // Longitude Input Field
              TextField(
                controller: longitudeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'خط الطول (Longitude)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Latitude Input Field
              TextField(
                controller: latitudeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'خط العرض (Latitude)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Add Donation Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedBloodType != null &&
                        locationController.text.isNotEmpty &&
                        latitudeController.text.isNotEmpty &&
                        longitudeController.text.isNotEmpty) {
                      // Parse latitude and longitude
                      final double? latitude =
                      double.tryParse(latitudeController.text.trim());
                      final double? longitude =
                      double.tryParse(longitudeController.text.trim());

                      if (latitude != null && longitude != null) {
                        donationController.addDonation({
                          'bloodType': selectedBloodType!.displayName,
                          'location': locationController.text.trim(),
                          'latitude': latitude,
                          'longitude': longitude,
                          'createdAt': DateTime.now(),
                          'active': true,
                        });
                        Get.snackbar('تم', 'تمت إضافة طلب الدم بنجاح!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      } else {
                        Get.snackbar('خطأ', 'خط العرض/الطول غير صحيح',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    } else {
                      Get.snackbar('خطأ', 'الرجاء ملء كل الحقول',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                  const Text('إضافة الطلب', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
