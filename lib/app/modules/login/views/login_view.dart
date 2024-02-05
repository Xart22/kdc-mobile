import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
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
            const SizedBox(height: 20),
            Container(
              height: 250,
              width: 250,
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
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PIN",
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
                        textInputAction: TextInputAction.next,
                        onChanged: controller.usernameOnChanged,
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          hintText: "Masukkan PIN",
                          hintStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          errorText: controller.usernameError.value != ''
                              ? controller.usernameError.value
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 12.0),
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                Text("PIN",
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
                        textInputAction: TextInputAction.next,
                        onChanged: controller.usernameOnChanged,
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          hintText: "Masukkan PIN",
                          hintStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          errorText: controller.usernameError.value != ''
                              ? controller.usernameError.value
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 12.0),
                        ),
                      ),
                    )),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffED1C24)),
                  child: TextButton(
                    onPressed: () {},
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
    );
  }
}
