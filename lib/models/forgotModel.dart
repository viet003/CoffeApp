
class ForgotResponseModel {
  final int err;
  final String msg;

  ForgotResponseModel({
    this.err = -1,
    this.msg = ''
  });

  factory ForgotResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotResponseModel(
      err: json["err"] != null ? json["err"] : "",
      msg: json["msg"] != null ? json["msg"] : "",
    );
  }
}

class ForgotRequestModel {
  String email;

  ForgotRequestModel({
    this.email = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
    };

    return map;
  }
}