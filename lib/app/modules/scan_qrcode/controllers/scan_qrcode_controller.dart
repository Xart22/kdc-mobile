import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:kdc_mobile/app/helper/snackbar.dart';
import 'package:kdc_mobile/app/services/api/queue_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrcodeController extends GetxController {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController noDoController = TextEditingController();
  late MobileScannerController controllerScanner;
  var arguments =
      MobileScannerArguments(size: const Size(0, 0), hasTorch: false).obs;

  var barcode = const Barcode().obs;
  var capture = BarcodeCapture().obs;

  var role = ''.obs;
  var isLoading = false.obs;
  var isTablet = false.obs;
  var showScannerField = false.obs;
  String id = "";
  String noPol = "";

  onDetect(BarcodeCapture barcode) async {
    id = barcode.barcodes.first.displayValue!.split("|")[0];
    noPol = barcode.barcodes.first.displayValue!.split("|")[1];
    controllerScanner.stop();
    isLoading.value = true;
    await QueueProvider.getQueueByid(id).then((value) async {
      if (value.status == "Waiting Loading Process") {
        await updateStatus("Loading Process");
      } else if (value.status == "Loading Process") {
        await updateStatus("Taking DO");
      } else if (value.status == "Waiting Exit") {
        await updateStatus("Process Done");
      } else {
        Get.back();
        showToast("Error", "Data tidak ditemukan");
      }
    });
  }

  updateByTablet() async {
    id = barcodeController.text.split(",")[0].replaceAll("id:", "");
    noPol = barcodeController.text.split(",")[1];
    isLoading.value = true;
    await QueueProvider.getQueueByid(id).then((value) async {
      if (value.status != 'Taking DO') {
        Get.back();
        showToast("Error", "Data tidak ditemukan");
      } else {
        await updateStatus("Waiting Exit");
      }
    });
  }

  updateStatus(String status) async {
    await QueueProvider.updateStatus(id, status).then((value) {
      if (value) {
        Get.back();
        showToast("Success", "Data berhasil diupdate");
      }
    });
  }

  @override
  void onInit() async {
    role.value = await GetStorage().read('user')['role'];
    if (role.value == 'Security') {
      controllerScanner = MobileScannerController(facing: CameraFacing.front);
    } else {
      controllerScanner = MobileScannerController(facing: CameraFacing.back);
    }
    isTablet.value = Get.width > 650;

    super.onInit();
  }
}
