import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/signUpModel.dart';
import './enviroment.dart';

class signUpController {
  Future<SignUpResponseModel> signUp(SignUpRequestModel requestModel) async {
    Uri url = Uri.parse('${Environment.apiUrl}register');

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return SignUpResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}