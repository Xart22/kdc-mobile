import 'package:get/get.dart';

import '../controllers/list_kendaraan_controller.dart';

class ListKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListKendaraanController>(
      () => ListKendaraanController(),
    );
  }
}
