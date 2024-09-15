import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/donation_controller.dart';

class DonorListScreen extends StatelessWidget {
  final DonationController donationController = Get.put(DonationController());

  DonorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المترعين'),
      ),
      body: Obx(() {
        if (donationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (donationController.donors.isEmpty) {
          return const Center(child: Text('لا يوجد متبرعين'));
        }
        return ListView.separated(
          itemCount: donationController.donors.length,
          itemBuilder: (context, index) {
            var donor = donationController.donors[index];
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                leading:  const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                trailing: Chip(
                    label: Text(donor['bloodType']),
                  avatar: const Icon(Icons.bloodtype),
                ),
                title: Text(donor['firstName'] + " " + donor['lastName']),
                subtitle: Text('${donor['address']}'),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return const Divider();
        },
        );
      }),
    );
  }
}
