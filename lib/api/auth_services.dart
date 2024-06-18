import 'dart:convert';

import 'package:tugasakhir/config/app_constant.dart';
import 'package:tugasakhir/model/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<AuthModel> login(String email, String password) async {
    var url = Uri.parse('${AppConstant.baseUrl}/api/login');

    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    var data = jsonDecode(response.body);
    print(password);

    try {
      if (response.statusCode == 200) {
        return AuthModel.fromJson(data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      rethrow;
    }
  }
}
