import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './enviroment.dart';

class UserController {
  // lấy toàn bộ tài khoản
  Future<List<Map<String, dynamic>>> getUsers() async {
    Uri url = Uri.parse('${Environment.apiUrl}getaccount');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> userList = [];
      List<dynamic> jsonData = convert.jsonDecode(response.body);

      for (var userJson in jsonData) {
        userList.add(userJson as Map<String, dynamic>);
      }
      return userList;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // xoá userb
  Future<Map<String, dynamic>> deleteUsers(Map<String, dynamic> data) async {
    Uri url = Uri.parse('${Environment.apiUrl}deleteaccount');

    final response = await http.delete(url, headers: {"Content-type": "application/json"}, body: convert.jsonEncode(data));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = convert.jsonDecode(response.body);

      return jsonData;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // lock, unlock account
  Future<Map<dynamic, dynamic>> setState(Map<String, dynamic> data) async {
    try {
      Uri url = Uri.parse('${Environment.apiUrl}setstate');
      print(convert.jsonEncode(data));
      final response = await http.post(url, headers: {"Content-type": "application/json"}, body: convert.jsonEncode(data));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = convert.jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw e;
    }
  }

// sửa mật khẩu
}
