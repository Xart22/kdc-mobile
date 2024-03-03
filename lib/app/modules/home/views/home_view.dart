import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Text('Selamat Datang ${controller.user.value}',
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                      ))),
                  const SizedBox(height: 20),
                  Obx(
                    () => controller.isTablet.value
                        ? Container()
                        : Container(
                            height: Get.height * 0.2 + 30,
                            width: Get.width,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/home.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/service.png'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('Layanan',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Obx(() => controller.role.value == 'Security'
                      ? buttonMenu(const Icon(Icons.add),
                          'Tambah Data Kendaraan', '/add-data-kendaraan')
                      : Container()),
                  // buttonMenu(const Icon(Icons.list), 'Daftar Antrian',
                  //     '/list-vehicle'),

                  buttonMenu(const Icon(Icons.qr_code_scanner), 'Scan QR Code',
                      '/scan-qrcode'),
                  SizedBox(height: Get.height * 0.1 - 30),
                  SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          controller.logout();
                        },
                        child: Text('Keluar',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                      ))
                ],
              )),
        ));
  }

  Container buttonMenu(Icon icon, String title, String route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        leading: icon,
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
        onTap: () {
          Get.toNamed(route);
        },
      ),
    );
  }
}
