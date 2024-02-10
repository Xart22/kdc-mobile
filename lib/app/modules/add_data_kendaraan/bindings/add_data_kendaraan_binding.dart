import 'package:get/get.dart';

import '../controllers/add_data_kendaraan_controller.dart';

class AddDataKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDataKendaraanController>(
      () => AddDataKendaraanController(),
    );
  }
}
