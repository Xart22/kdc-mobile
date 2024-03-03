import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String title, String message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white);
}
