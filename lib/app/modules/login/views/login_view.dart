import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Silahkan masuk ke akun anda',
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Container(
                height: Get.height * 0.3,
                width: Get.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/truck.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username",
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.black,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8EDF1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.usernameController,
                      onChanged: controller.usernameOnChanged,
                      decoration: InputDecoration(
                        hintText: "Masukkan Username",
                        hintStyle: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(() => Text(
                        controller.usernameError.value,
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      )),
                  const SizedBox(height: 10),
                  Text("Password",
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.black,
                      )),
                  Obx(() => Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8EDF1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          onChanged: controller.passwordOnChanged,
                          controller: controller.passwordController,
                          obscureText: !controller.showPassword.value,
                          decoration: InputDecoration(
                            hintText: "Masukkan Password",
                            hintStyle: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 12.0),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              },
                              icon: Icon(
                                controller.showPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 5),
                  Obx(() => Text(
                        controller.passwordError.value,
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      )),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffED1C24)),
                    child: TextButton(
                      onPressed: () {
                        controller.login();
                      },
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
