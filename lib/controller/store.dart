import 'package:coffeeapp/models/loginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  // Đổi từ khóa void thành Future<void> để phản ánh việc hàm này là một Future không trả về giá trị
  Future<void> saveToken(LoginResponseModel value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value.token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    return token;
  }

  Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

}
