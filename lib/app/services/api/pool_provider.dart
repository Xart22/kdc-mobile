import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/helper/snackbar.dart';
import '../../helper/config.dart';

class PoolProvider {
  static final client = http.Client();
  static final storage = GetStorage();

  static Future<String> getNoUrut() async {
    var token = await storage.read('accestoken');
    try {
      final response = await client.get(Uri.parse(Config.getNoUrut),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['no_urut'].toString();
      } else {
        Get.snackbar('Error', 'Failed to load data');
        throw Exception('Failed to load data');
      }
    } catch (e, s) {
      print(s);
      throw Exception('Failed to load data');
    }
  }

  static Future<String> createVehicle(Map<String, dynamic> data) async {
    var token = await storage.read('accestoken');
    try {
      var body = data.map((key, value) {
        return MapEntry(key, value.toString());
      });
      final response = await client.post(Uri.parse(Config.createVehicle),
          body: body, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['vehicle_id'].toString();
      } else {
        showToast('Error', 'Failed to create data');
        throw Exception('Failed to load data');
      }
    } catch (e, s) {
      print(s);
      throw Exception('Failed to load data');
    }
  }
}
