import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/loginModel.dart';
import './enviroment.dart';

class loginController {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse('${Environment.apiUrl}login');

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}