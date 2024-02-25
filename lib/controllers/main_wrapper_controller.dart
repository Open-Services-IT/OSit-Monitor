import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;

  /// Variable for changing index of Bottom AppBar
  RxInt currentPage = 0.obs;
  List<String> titles = ['QR', 'NFC'];
  RxString title = ''.obs;
  void goToTab(int page) {
    title.value = titles[currentPage.value];
    currentPage.value = page;
    pageController.jumpToPage(page);
    update();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    title.value = titles[1];
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
