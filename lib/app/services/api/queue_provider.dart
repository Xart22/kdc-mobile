import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/data/model/queue_response.dart';
import '../../helper/config.dart';

class QueueProvider {
  static final client = http.Client();

  static Future<List<QueueModel>> getQueues() async {
    final response = await client.get(Uri.parse(Config.queuesUrl));
    if (response.statusCode == 200) {
      return queueModelFromJson(response.body);
    } else {
      Get.snackbar('Error', 'Failed to load data');
      throw Exception('Failed to load data');
    }
  }
}
