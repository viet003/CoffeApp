class SignUpResponseModel {
  final int err;
  final String msg;

  SignUpResponseModel({
    this.err = -1,
    this.msg = ''
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      err: json["err"] != null ? json["err"] : "",
      msg: json["msg"] != null ? json["msg"] : "fuck",
    );
  }
}

class SignUpRequestModel {
  String username;
  String email;
  String password;

  SignUpRequestModel({
    this.username = '',
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}