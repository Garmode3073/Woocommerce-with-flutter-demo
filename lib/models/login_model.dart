class LoginResponseModel {
  bool? success;
  int? statuscode;
  String? code;
  String? message;
  Data? data;

  LoginResponseModel({
    this.code,
    this.data,
    this.message,
    this.statuscode,
    this.success,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    statuscode = json['statuscode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['message'] = this.message;
    data['statuscode'] = this.statuscode;
    data['success'] = this.success;

    return data;
  }
}

class Data {
  String? token;
  int? id;
  String? email;
  String? nickname;
  String? firstname;
  String? lastname;
  String? displayName;

  Data({
    this.token,
    this.displayName,
    this.email,
    this.firstname,
    this.id,
    this.lastname,
    this.nickname,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    nickname = json['nickname'];
    firstname = json['firstname'];
    displayName = json['displayname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['nickname'] = this.nickname;
    data['firstname'] = this.firstname;
    data['displayName'] = this.displayName;

    return data;
  }
}
