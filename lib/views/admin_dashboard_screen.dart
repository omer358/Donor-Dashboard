import 'package:blood_donor_dashboard/controllers/auth_controller.dart';
import 'package:blood_donor_dashboard/views/blood_request.dart';
import 'package:blood_donor_dashboard/views/donation_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';
import '../controllers/donation_request_controller.dart';
import 'donor_list_screen.dart';

class AdminDashboardScreen extends StatefulWidget {

  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AdminController adminController = Get.put(AdminController());

  final DonationRequestsController donationRequests = Get.put(DonationRequestsController());

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
              trailing: IconButton(
                icon: const Icon(Icons.logout)
                , onPressed: () {
                  Get.find<AuthController>().logout();
              },
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text('Add Donation'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bloodtype_rounded),
                  label: Text('Donation Requests'),
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
                    return BloodRequest();
                  case 1:
                    return DonationRequests();
                  case 2:
                    return DonorListScreen();
                  default:
                    return DonorListScreen();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
