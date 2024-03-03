import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kdc_mobile/app/helper/snackbar.dart';
import '../../helper/config.dart';

class AuthProvider {
  static final client = http.Client();
  static final storage = GetStorage();

  static Future<bool> login(String username, String password) async {
    try {
      final response = await client.post(Uri.parse(Config.loginUrl),
          body: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        storage.write('accestoken', responseJson['token']);
        storage.write('user', responseJson['user']);
        return true;
      } else {
        showToast('Error', 'Username atau password salah');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> logout() async {
    var token = await storage.read('accestoken');
    try {
      final response = await client.post(Uri.parse(Config.logoutUrl),
          headers: {'Authorization': 'Bearer $token'});
      print(response.body);
      if (response.statusCode == 200) {
        storage.remove('accestoken');
        storage.remove('user');
        return true;
      } else {
        showToast('Error', 'Gagal logout');
        print(response.body);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load data');
    }
  }
}
