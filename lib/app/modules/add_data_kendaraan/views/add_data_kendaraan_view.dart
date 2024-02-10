import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdc_mobile/app/data/model/queue_response.dart';
import 'package:kdc_mobile/app/helper/loading.dart';
import '../controllers/add_data_kendaraan_controller.dart';

class AddDataKendaraanView extends GetView<AddDataKendaraanController> {
  const AddDataKendaraanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Kendaraan Masuk'),
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
                'TAMBAH ANTRIAN',
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
              Text("Pilih Trasport",
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Obx(() => DropdownSearch<QueueModel>(
                    filterFn: (item, filter) => item
                        .toString()
                        .toLowerCase()
                        .contains(filter.toLowerCase()),
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: 'Cari Trasport',
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
                        hintText: 'Pilih Trasport',
                        filled: true,
                      ),
                    ),
                    items: controller.data.toList(),
                    itemAsString: (item) =>
                        '${item.transport.transport} - ${item.tujuan.tujuan} - ${item.jenisKendaraan.jenisKendaraan}',
                    onChanged: (value) {
                      controller.onSelectedData(value);
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              textInputBuilder(
                  'Nomor Gate', controller.nomorGateController, true),
              const SizedBox(
                height: 20,
              ),
              tnkbBuilder(),
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
                      'Cetak Barcode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
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
                      Get.toNamed('/addDataKendaraan');
                    },
                    child: const Text(
                      'Daftar Antrian',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
              )
            ]),
          ),
          Obx(() => controller.isLoading.value ? const Loading() : Container()),
        ]));
  }

  Column tnkbBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nomor TNKB',
            style: GoogleFonts.openSans(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w700)),
        Row(
          children: [
            Container(
                width: Get.width * 0.2,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffE8EDF1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.kodeWilayahController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'B',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xffE8EDF1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: controller.nomorTnkbController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: '1234',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 12.0),
                    ),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                width: Get.width * 0.2,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffE8EDF1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.seriWilayahController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                  ],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'ABC',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget textInputBuilder(
      String title, TextEditingController ctr, bool disabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.openSans(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w700)),
        Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: const Color(0xffE8EDF1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: ctr,
              readOnly: disabled,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              ),
            )),
      ],
    );
  }
}
