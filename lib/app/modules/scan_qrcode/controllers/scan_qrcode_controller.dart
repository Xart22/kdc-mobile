import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:kdc_mobile/app/helper/snackbar.dart';
import 'package:kdc_mobile/app/services/api/queue_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrcodeController extends GetxController {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController noDoController = TextEditingController();
  late MobileScannerController controllerScanner = MobileScannerController();
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
      if (value.status == "Waiting Loading Process" &&
          role.value == "Warehouse Koordinator") {
        await updateStatus("Loading Process");
      } else if (value.status == "Loading Process" &&
          role.value == "Warehouse Koordinator") {
        await updateStatus("Taking DO");
      } else {
        Get.back();
        showToast("Error", "Data tidak ditemukan");
      }
    });
  }

  updateByTablet() async {
    id = barcodeController.text.split("|")[0];
    noPol = barcodeController.text.split("|")[1];
    isLoading.value = true;
    await QueueProvider.getQueueByid(id).then((value) async {
      if (value.status == 'Taking DO') {
        await updateStatus("Waiting Exit");
      } else if (value.status == 'Waiting Exit') {
        await updateStatus("Process Done");
      }
    });
  }

  updateStatus(String status) async {
    await QueueProvider.updateStatus(id, status).then((value) {
      if (value) {
        Get.back();
        showToast("Success", "Data berhasil diupdate");
      } else {
        showToast("error", "Status Tidak Valid");
      }
    });
  }

  @override
  void onInit() async {
    role.value = await GetStorage().read('user')['role'];
    isTablet.value = Get.width > 650;

    super.onInit();
  }
}
