import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/donation_controller.dart';

class DonorListScreen extends StatelessWidget {
  final DonationController donationController = Get.put(DonationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (donationController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (donationController.donors.isEmpty) {
        return Center(child: Text('No donors found.'));
      }
      return ListView.builder(
        itemCount: donationController.donors.length,
        itemBuilder: (context, index) {
          var donor = donationController.donors[index];
          return ListTile(
            title: Text(donor['name']),
            subtitle: Text('Blood Type: ${donor['bloodType']}'),
          );
        },
      );
    });
  }
}
