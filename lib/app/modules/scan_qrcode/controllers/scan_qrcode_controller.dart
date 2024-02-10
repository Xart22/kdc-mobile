import 'dart:ui';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrcodeController extends GetxController {
  late MobileScannerController controllerScanner = MobileScannerController();
  var arguments =
      MobileScannerArguments(size: const Size(0, 0), hasTorch: false).obs;

  var barcode = const Barcode().obs;
  var capture = BarcodeCapture().obs;

  var isLoading = false.obs;
  var isTablet = false.obs;

  onDetect(BarcodeCapture barcode) {
    capture.value = barcode;
    this.barcode.value = barcode.barcodes.first;
    isLoading.value = true;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    isTablet.value = Get.width > 650;
    super.onReady();
  }
}
