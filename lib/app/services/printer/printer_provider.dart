import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as FlutterBluePluss;
import 'package:get/get.dart';

class PrinterService extends GetxService {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  String address = '86:67:7A:0D:EC:27';

  Future<PrinterService> initPrinter() async {
    if (await FlutterBluePluss.FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
    }
    FlutterBluePluss.FlutterBluePlus.adapterState
        .listen((FlutterBluePluss.BluetoothAdapterState state) async {
      if (state == FlutterBluePluss.BluetoothAdapterState.on) {
        await bluetoothPrint
            .connect(BluetoothDevice.fromJson({'address': address}));
      } else {
        FlutterBluePluss.FlutterBluePlus.turnOn();
      }
    });

    bluetoothPrint.state.listen((state) {
      print('cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          print('connected');
          break;
        case BluetoothPrint.DISCONNECTED:
          print('disconnected');
          break;
        default:
          print('default');
          break;
      }
    });
    return this;
  }
}
