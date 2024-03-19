import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdc_mobile/app/data/model/kendaraan_response.dart';
import 'package:kdc_mobile/app/helper/loading.dart';

import '../controllers/list_kendaraan_controller.dart';

class ListKendaraanView extends GetView<ListKendaraanController> {
  const ListKendaraanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('List Kendaraan Masuk'),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.red),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Text(
                'DATA ANTRIAN',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const SizedBox(
                height: 8,
              ),
              Obx(() => Center(
                      child: Text(
                    controller.time.value,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ))),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              Text("Pilih Kendaraan",
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              DropdownSearch<Kendaraan>(
                filterFn: (item, filter) => item.noPolisi
                    .toString()
                    .toLowerCase()
                    .contains(filter.toLowerCase()),
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: 'Cari Kendaraan',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Pilih Kendaraan',
                    filled: true,
                  ),
                ),
                items: controller.dataKendaraan,
                itemAsString: (item) =>
                    "${item.noPolisi} - ${item.tujuan.tujuan} - ${item.transport.transport}",
                onChanged: (value) {
                  controller.selectedKendaraan = value!;
                  RegExp regex = RegExp(r'^[A-Za-z]{1,2}');
                  RegExpMatch? match = regex.firstMatch(value.noPolisi);
                  String? bagian1 = match != null ? match.group(0) : "";
                  String bagian2 = value.noPolisi
                      .substring(bagian1!.length, bagian1.length + 4);
                  String bagian3 = value.noPolisi.substring(bagian1.length + 4);
                  controller.kodeWilayahController.text = bagian1;
                  controller.nomorTnkbController.text = bagian2;
                  controller.seriWilayahController.text = bagian3;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      controller.printBarcode();
                    },
                    child: const Text(
                      'Cetak Ulang Barcode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
              ),
            ]),
          ),
          Obx(() => controller.isLoading.value ? const Loading() : Container()),
        ]));
  }
}
