import 'dart:developer';

import 'package:get/get.dart';

class AdminController extends GetxController {
  var selectedPage = 0.obs;

  void changePage(int index) {
    log("the current index is $index");
    selectedPage.value = index;
    log("the new selectedPage is ${selectedPage.value}");
  }
}
