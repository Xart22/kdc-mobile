import 'dart:async';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kdc_mobile/app/data/model/kendaraan_response.dart';

import 'package:kdc_mobile/app/services/api/pool_provider.dart';

import 'package:kdc_mobile/app/services/printer/printer_provider.dart';

class ListKendaraanController extends GetxController {
  TextEditingController nomoUrutController = TextEditingController();
  TextEditingController kodeWilayahController = TextEditingController();
  TextEditingController nomorTnkbController = TextEditingController();
  TextEditingController seriWilayahController = TextEditingController();

  DateTime now = DateTime.now();
  var time = ''.obs;
  var isLoading = true.obs;
  var dataKendaraan = <Kendaraan>[].obs;

  Kendaraan? selectedKendaraan;

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      time.value = DateFormat('dd-MM-yyyy HH:mm').format(now).toString();
    });
  }

  getData() async {
    await PoolProvider.getKendaraan().then((value) {
      dataKendaraan.value = value.data;
    });
    isLoading.value = false;
  }

  printBarcode() async {
    String data =
        "${selectedKendaraan!.id}|${kodeWilayahController.text}${nomorTnkbController.text}${seriWilayahController.text}";
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tanggal / Waktu',
        weight: 3,
        height: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: selectedKendaraan!.jamMasuk,
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Transport',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: selectedKendaraan!.transport.transport,
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tujuan',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: selectedKendaraan!.tujuan.tujuan,
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Nomor TNKB",
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content:
            "${kodeWilayahController.text} ${nomorTnkbController.text} ${seriWilayahController.text}",
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "No Urut",
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: selectedKendaraan!.noUrut.toString(),
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
      type: LineText.TYPE_QRCODE,
      content: data,
      align: LineText.ALIGN_CENTER,
      size: 20,
    ));
    list.add(LineText(linefeed: 1));

    await PrinterService().bluetoothPrint.printReceipt(config, list);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
    startTimer();
  }
}
