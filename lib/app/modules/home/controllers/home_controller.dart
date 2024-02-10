import 'package:get/get.dart';
import 'package:kdc_mobile/app/services/printer/printer_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var isTablet = false.obs;

  initPermission() async {
    var status = await Permission.bluetooth.status;
    var status2 = await Permission.bluetoothConnect.status;
    var status3 = await Permission.bluetoothScan.status;
    if (!status.isGranted || !status2.isGranted || !status3.isGranted) {
      await Permission.bluetooth.request();
      await Permission.bluetoothConnect.request();
      await Permission.bluetoothScan.request();
    } else {
      await Get.putAsync<PrinterService>(() => PrinterService().initPrinter());
    }
  }

  @override
  void onInit() async {
    isTablet.value = Get.width > 650;
    super.onInit();
    await initPermission();
  }
}
