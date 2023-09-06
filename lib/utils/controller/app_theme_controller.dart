import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}