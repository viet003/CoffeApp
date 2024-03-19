import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/forgotModel.dart';
import './enviroment.dart';

class forgotController {
  Future<ForgotResponseModel> forgot(ForgotRequestModel requestModel) async {
    Uri url = Uri.parse('${Environment.apiUrl}getpass');

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ForgotResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}