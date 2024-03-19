import 'dart:async';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kdc_mobile/app/data/model/jenis_kendaraan_response.dart';
import 'package:kdc_mobile/app/data/model/transport_response.dart';
import 'package:kdc_mobile/app/data/model/tujuan_response.dart';
import 'package:kdc_mobile/app/helper/snackbar.dart';
import 'package:kdc_mobile/app/services/api/jenis_kendaraan_provider.dart';
import 'package:kdc_mobile/app/services/api/pool_provider.dart';
import 'package:kdc_mobile/app/services/api/transport_provider.dart';
import 'package:kdc_mobile/app/services/api/tujuan_provider.dart';
import 'package:kdc_mobile/app/services/printer/printer_provider.dart';

class AddDataKendaraanController extends GetxController {
  TextEditingController nomoUrutController = TextEditingController();
  TextEditingController kodeWilayahController = TextEditingController();
  TextEditingController nomorTnkbController = TextEditingController();
  TextEditingController seriWilayahController = TextEditingController();

  DateTime now = DateTime.now();
  var time = ''.obs;
  var isLoading = true.obs;
  var dataTujuan = <Tujuan>[].obs;
  var dataTransport = <Transport>[].obs;
  var dataJenisKendaraan = <JenisKendaraan>[].obs;

  Tujuan? selectedTujuan;
  Transport? selectedTransport;
  JenisKendaraan? selectedJenisKendaraan;

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      time.value = DateFormat('dd-MM-yyyy HH:mm').format(now).toString();
    });
  }

  void checkPrinter() async {
    await PrinterService().bluetoothPrint.isConnected.then((value) async {
      if (!value!) {
        await PrinterService().connectPrinter();
      }
    });
  }

  getData() async {
    isLoading.value = true;
    await TujuanProvider.getData().then((value) {
      dataTujuan.value = value.data;
    });
    await TransportProvider.getData().then((value) {
      dataTransport.value = value.data;
    });
    await JenisKendaraanProvider.getData().then((value) {
      dataJenisKendaraan.value = value.data;
    });
    await PoolProvider.getNoUrut().then((value) {
      nomoUrutController.text = value;
    });
    isLoading.value = false;
  }

  validateData() {
    if (selectedTransport == null) {
      showToast('Error', 'Transport harus diisi');
      return false;
    }
    if (selectedTujuan == null) {
      showToast('Error', 'Tujuan harus diisi');
      return false;
    }
    if (selectedJenisKendaraan == null) {
      showToast('Error', 'Jenis Kendaraan harus diisi');
      return false;
    }
    if (kodeWilayahController.text.isEmpty) {
      showToast('Error', 'Kode Wilayah harus diisi');
      return false;
    }
    if (nomorTnkbController.text.isEmpty) {
      showToast('Error', 'Nomor TNKB harus diisi');
      return false;
    }
    if (seriWilayahController.text.isEmpty) {
      showToast('Error', 'Seri Wilayah harus diisi');
      return false;
    }
    return true;
  }

  updateBarcode() async {
    if (!validateData()) {
      return;
    }

    await PoolProvider.createVehicle({
      "no_urut": nomoUrutController.text,
      "no_polisi":
          "${kodeWilayahController.text}${nomorTnkbController.text}${seriWilayahController.text}",
      "jenis_kendaraan_id": selectedJenisKendaraan!.id,
      "tujuan_id": selectedTujuan!.id,
      "transport_id": selectedTransport!.id,
    }).then((value) {
      if (value.isNotEmpty) {
        printBarcode(value, nomoUrutController.text);
        Get.back();
        showToast('Success', 'Data berhasil disimpan');
      } else {
        showToast('Error', 'Gagal menyimpan data');
      }
    });
  }

  printBarcode(String id, String noUrut) async {
    checkPrinter();
    String data =
        "$id|${kodeWilayahController.text}${nomorTnkbController.text}${seriWilayahController.text}";
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
        content: 'Transport',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: selectedTransport!.transport,
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
        content: selectedTujuan!.tujuan,
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
        content: noUrut,
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
