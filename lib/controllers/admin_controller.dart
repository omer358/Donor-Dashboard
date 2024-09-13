import 'package:get/get.dart';

class AdminController extends GetxController {
  var selectedPage = 0.obs;

  void changePage(int index) {
    selectedPage.value = index;
  }
}
