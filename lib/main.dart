import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kdc_mobile/app/services/printer/printer_provider.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<PrinterService>(() => PrinterService().initPrinter());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
