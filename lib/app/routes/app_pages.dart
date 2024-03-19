import 'package:get/get.dart';

import '../modules/add_data_kendaraan/bindings/add_data_kendaraan_binding.dart';
import '../modules/add_data_kendaraan/views/add_data_kendaraan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_kendaraan/bindings/list_kendaraan_binding.dart';
import '../modules/list_kendaraan/views/list_kendaraan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/scan_qrcode/bindings/scan_qrcode_binding.dart';
import '../modules/scan_qrcode/views/scan_qrcode_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DATA_KENDARAAN,
      page: () => const AddDataKendaraanView(),
      binding: AddDataKendaraanBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QRCODE,
      page: () => const ScanQrcodeView(),
      binding: ScanQrcodeBinding(),
    ),
    GetPage(
      name: _Paths.LIST_KENDARAAN,
      page: () => const ListKendaraanView(),
      binding: ListKendaraanBinding(),
    ),
  ];
}
