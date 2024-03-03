import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/data/model/batch_response.dart';
import '../../helper/config.dart';

class BatchProvider {
  static final client = http.Client();
  static final storage = GetStorage();

  static Future<BatchResponse> getBatches() async {
    var token = await storage.read('accestoken');
    try {
      final response = await client.get(Uri.parse(Config.batchUrl),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return batchResponseFromJson(response.body);
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
