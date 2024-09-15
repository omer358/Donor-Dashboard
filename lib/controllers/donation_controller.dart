import 'package:get/get.dart';
import '../services/admin_service.dart';

class DonationController extends GetxController {
  var donors = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonors();
  }

  void fetchDonors(){
    // Use a Stream to listen to changes in the donors collection
    AdminService().getAllDonors().listen((donorList) {
      donors.value = donorList;
      isLoading.value = false;
    }).onError((error) {
      print("Error fetching donors: $error");
      isLoading.value = false; // Stop loading if there's an error
    });
  }

  void addDonation(Map<String, dynamic> donationData) {
    AdminService().addDonation(donationData);
  }
}
