import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var usernameError = ''.obs;

  void usernameOnChanged(String value) {
    print(value);
  }
}
