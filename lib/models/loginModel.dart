class LoginResponseModel {
  final String token;
  final int err;
  final String msg;

  LoginResponseModel({
    this.token = '',
    this.err = -1,
    this.msg = ''
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      err: json["err"] != null ? json["err"] : "",
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}