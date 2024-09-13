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

  void fetchDonors() async {
    isLoading.value = true;
    donors.value = await AdminService().getAllDonors();
    isLoading.value = false;
  }

  void addDonation(Map<String, dynamic> donationData) {
    AdminService().addDonation(donationData);
  }
}
