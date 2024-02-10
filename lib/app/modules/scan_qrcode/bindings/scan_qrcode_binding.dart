import 'package:get/get.dart';

import '../controllers/scan_qrcode_controller.dart';

class ScanQrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrcodeController>(
      () => ScanQrcodeController(),
    );
  }
}
