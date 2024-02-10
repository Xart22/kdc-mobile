import 'dart:async';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kdc_mobile/app/data/model/queue_response.dart';
import 'package:kdc_mobile/app/services/api/queue_provider.dart';
import 'package:kdc_mobile/app/services/printer/printer_provider.dart';

class AddDataKendaraanController extends GetxController {
  var time = ''.obs;
  TextEditingController nomorGateController = TextEditingController();
  TextEditingController perusahaanController = TextEditingController();
  TextEditingController kodeWilayahController = TextEditingController();
  TextEditingController nomorTnkbController = TextEditingController();
  TextEditingController seriWilayahController = TextEditingController();

  var data = <QueueModel>[].obs;
  QueueModel? selectedData;

  var isLoading = true.obs;

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      var now = DateTime.now();
      time.value = DateFormat('dd-MM-yyyy HH:mm').format(now).toString();
    });
  }

  getDataQueues() async {
    await QueueProvider.getQueues().then((value) {
      data.assignAll(value);
      isLoading.value = false;
    });
  }

  onSelectedData(QueueModel? value) {
    selectedData = value;
    nomorGateController.text = value!.gate.toString();
  }

  printBarcode() async {
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
        content: time.value,
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Nomor Gate',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: nomorGateController.text,
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
        content: selectedData!.transport.transport,
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
        content: "D 1234 AB",
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
      type: LineText.TYPE_QRCODE,
      content: 'D 1234 AB',
      align: LineText.ALIGN_CENTER,
      size: 20,
    ));
    list.add(LineText(linefeed: 1));

    await PrinterService().bluetoothPrint.printReceipt(config, list);
  }

  @override
  void onInit() {
    getDataQueues();
    super.onInit();
    startTimer();
  }
}
