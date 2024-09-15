import 'package:blood_donor_dashboard/services/admin_service.dart';
import 'package:get/get.dart';

class DonationRequestsController extends GetxController {
  final AdminService _firestoreService = AdminService();

  // List to hold blood donation requests
  var donationRequests = <Map<String, dynamic>>[].obs;

  // Method to fetch donation requests from Firestore
  void fetchDonationRequests() {
    _firestoreService.getBloodRequests().listen((requests) {
      donationRequests.assignAll(requests);
    });
  }

  // Update the active status of a request
  Future<void> updateRequestStatus(String id, bool active) async {

    try {
      await _firestoreService.updateDonationRequest(id, active);
    } catch (e) {
      print("Error updating request status: $e");
    }
  }


  Future<void> deleteRequest(String id) async {
    try {
      await _firestoreService.deleteDonationRequest(id);
    } catch (e) {
      print("Error deleting request: $e");
    }
  }

  @override
  void onInit() {
    fetchDonationRequests();
    super.onInit();
  }
}
