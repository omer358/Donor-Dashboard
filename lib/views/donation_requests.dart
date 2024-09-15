import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/donation_request_controller.dart';

class DonationRequests extends StatelessWidget {
  final DonationRequestsController controller = Get.find<DonationRequestsController>();

  DonationRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation Requests'),
      ),
      body: Obx(() {
        if (controller.donationRequests.isEmpty) {
          return const Center(
            child: Text('No donation requests available'),
          );
        }

        return ListView.builder(
          itemCount: controller.donationRequests.length,
          itemBuilder: (context, index) {
            final request = controller.donationRequests[index];
            final id = request['id']; // You need to store the document ID
            return ListTile(
              title: Text(request['bloodType']),
              subtitle: Text(request['location']),
              trailing: Switch(
                value: request['active'],
                onChanged: (value) {
                  log("onChange has been trigered with $value");
                  log("the id is :$id");
                  controller.updateRequestStatus(id, value);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
