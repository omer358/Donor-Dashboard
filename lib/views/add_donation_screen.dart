import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/donation_controller.dart';

class AddDonationScreen extends StatelessWidget {
  final DonationController donationController = Get.put(DonationController());
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: bloodTypeController,
            decoration: InputDecoration(labelText: 'Blood Type'),
          ),
          TextField(
            controller: locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              donationController.addDonation({
                'bloodType': bloodTypeController.text,
                'location': locationController.text,
                'createdAt': DateTime.now(),
              });
            },
            child: Text('Add Donation'),
          ),
        ],
      ),
    );
  }
}
