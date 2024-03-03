import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/data/model/queue_response.dart';
import '../../helper/config.dart';

class QueueProvider {
  static final _client = http.Client();
  static final storage = GetStorage();

  static Future<bool> updateStatus(String id, String status) async {
    var token = await storage.read('accestoken');
    var body = {};
    if (status == "Loading Process") {
      body = {
        'status': status,
        'mulai_muat': DateTime.now().toString(),
      };
    }
    if (status == "Taking DO") {
      body = {
        'status': status,
        'selesai_muat': DateTime.now().toString(),
        "alert_loading": "0",
      };
    }
    if (status == "Waiting Exit") {
      body = {
        'status': status,
        'mulai_exit': DateTime.now().toString(),
      };
    }
    if (status == "Waiting Exit") {
      body = {
        'status': status,
        'selesai_exit': DateTime.now().toString(),
        'alert_exit': '0',
      };
    }
    if (status == "Process Done") {
      body = {
        'status': status,
        'selesai_exit': DateTime.now().toString(),
        'alert_exit': '0',
      };
    }

    final response = await _client
        .put(Uri.parse('${Config.queuesUrl}/$id'), body: body, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar('Error', 'Failed to update data');
      throw Exception('Failed to update data');
    }
  }

  static Future<Queue> getQueueByid(String id) async {
    var token = await storage.read('accestoken');
    final response = await _client.get(Uri.parse('${Config.queuesUrl}/$id'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      Queue queue = Queue.fromJson(json.decode(response.body)['data']);
      return queue;
    } else {
      Get.snackbar('Error', 'Failed to update data');
      throw Exception('Failed to update data');
    }
  }
}
