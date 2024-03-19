import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/data/model/tujuan_response.dart';
import '../../helper/config.dart';

class TujuanProvider {
  static final client = http.Client();
  static final storage = GetStorage();

  static Future<TujuanResponse> getData() async {
    try {
      var token = await storage.read('accestoken');
      final response = await client.get(Uri.parse(Config.tujuan),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return tujuanResponseFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load data');
        throw Exception('Failed to load data');
      }
    } catch (e, s) {
      print(s);
      throw Exception('Failed to load data');
    }
  }
}
