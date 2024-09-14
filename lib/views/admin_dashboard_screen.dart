import 'package:blood_donor_dashboard/views/donation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';
import 'donor_list_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AdminController adminController = Get.put(AdminController());

   AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: adminController.selectedPage.value,
              onDestinationSelected: adminController.changePage,
              labelType: NavigationRailLabelType.selected,
              elevation: 4,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text('Add Donation'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.list),
                  label: Text('Donors List'),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                switch (adminController.selectedPage.value) {
                  case 0:
                    return  AddDonationScreen();
                  case 1:
                    return DonorListScreen();
                  default:
                    return  DonorListScreen();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
