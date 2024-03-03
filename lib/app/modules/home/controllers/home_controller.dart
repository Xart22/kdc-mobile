import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kdc_mobile/app/services/api/auth_provider.dart';
import 'package:kdc_mobile/app/services/printer/printer_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var isTablet = false.obs;
  var user = ''.obs;
  var role = ''.obs;

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

  void logout() async {
    await AuthProvider.logout().then((value) {
      if (value) {
        Get.offAllNamed('/login');
      }
    });
  }

  @override
  void onInit() async {
    isTablet.value = Get.width > 650;
    user.value = await GetStorage().read('user')['name'];
    role.value = await GetStorage().read('user')['role'];
    super.onInit();
    if (isTablet.value) {
      await initPermission();
    }
  }
}
