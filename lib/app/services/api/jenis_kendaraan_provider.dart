import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/data/model/jenis_kendaraan_response.dart';
import '../../helper/config.dart';

class JenisKendaraanProvider {
  static final client = http.Client();
  static final storage = GetStorage();

  static Future<JenisKendaraanResponse> getData() async {
    var token = await storage.read('accestoken');
    try {
      final response = await client.get(Uri.parse(Config.jenisKendaraanUrl),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return jenisKendaraanResponseFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load data');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load data');
    }
  }
}
