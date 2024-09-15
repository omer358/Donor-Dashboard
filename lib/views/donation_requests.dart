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

        return ListView.separated(
          itemCount: controller.donationRequests.length,
          itemBuilder: (context, index) {
            final request = controller.donationRequests[index];
            final id = request['id']; // You need to store the document ID
            return Dismissible(
              key: Key(id), // Use the document ID as the key
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                log("onDismissed triggered for ID: $id");
                controller.deleteRequest(id); // Call the delete method
                // Show a snackbar or any other feedback mechanism
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم مسح طلب الدم')),
                );
              },
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              child: ListTile(
                title: Text(request['location']),
                subtitle: Text(request['bloodType']),
                trailing: Switch(
                  value: request['active'],
                  onChanged: (value) {
                    log("onChange has been triggered with $value");
                    log("The ID is: $id");
                    controller.updateRequestStatus(id, value);
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      }),
    );
  }
}
