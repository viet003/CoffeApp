import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './enviroment.dart';

class ProductController {
  // lấy toàn bộ sản phẩm
  Future<List<Map<String, dynamic>>> getProducts() async {
    Uri url = Uri.parse('${Environment.apiUrl}getproduct');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> productList = [];
      List<dynamic> jsonData = convert.jsonDecode(response.body);

      for (var userJson in jsonData) {
        productList.add(userJson as Map<String, dynamic>);
      }
      print(productList);
      return productList;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // thêm sản phẩm
  Future<Map<String, dynamic>> insertProduct(Map<dynamic, dynamic> data) async {
    Uri url = Uri.parse('${Environment.apiUrl}insertproduct');
    // print(convert.jsonEncode(data));
    final response = await http.post(url, headers: {"Content-type": "application/json"}, body: convert.jsonEncode(data));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load data! ${response.body}');
    }
  }

  // sửa thông tin sảm phẩm
  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> data) async {
    try {
      Uri url = Uri.parse('${Environment.apiUrl}updateproduct');
      final response = await http.put(url, headers: {"Content-type": "application/json"}, body: convert.jsonEncode(data));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = convert.jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to load data! ${response.body}');
      }
    } catch (e) {
      throw e;
    }
  }

  // xoá product
  Future<Map<String, dynamic>> deleteProduct(Map<String, dynamic> data) async {
    try {
      Uri url = Uri.parse('${Environment.apiUrl}deleteproduct');
      // print(convert.jsonEncode(data));
      final response = await http.delete(url, headers: {"Content-type": "application/json"}, body: convert.jsonEncode(data));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = convert.jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to load data! ${response.body}');
      }
    } catch(e) {
      throw e;
    }
  }

}
