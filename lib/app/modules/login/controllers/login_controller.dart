import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kdc_mobile/app/services/api/auth_provider.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var usernameError = ''.obs;
  var passwordError = ''.obs;
  var showPassword = false.obs;

  void usernameOnChanged(String value) {
    usernameError.value = '';
  }

  void passwordOnChanged(String value) {
    passwordError.value = '';
  }

  void login() async {
    if (usernameController.text.isEmpty) {
      usernameError.value = 'Username tidak boleh kosong';
    }
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password tidak boleh kosong';
    }
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      await AuthProvider.login(usernameController.text, passwordController.text)
          .then((value) {
        if (value) {
          Get.offAllNamed('/home');
        }
      });
    }
  }
}
