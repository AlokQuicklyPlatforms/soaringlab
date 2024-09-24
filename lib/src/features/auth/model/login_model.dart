// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  Items? items;

  LoginModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  LoginModel copyWith({
    bool? status,
    int? subCode,
    String? message,
    String? error,
    Items? items,
  }) =>
      LoginModel(
        status: status ?? this.status,
        subCode: subCode ?? this.subCode,
        message: message ?? this.message,
        error: error ?? this.error,
        items: items ?? this.items,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        subCode: json["subCode"],
        message: json["message"],
        error: json["error"],
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subCode": subCode,
        "message": message,
        "error": error,
        "items": items?.toJson(),
      };
}

class Items {
  String? userId;
  String? email;
  String? token;
  int? status;

  Items({
    this.userId,
    this.email,
    this.token,
    this.status,
  });

  Items copyWith({
    String? userId,
    String? email,
    String? token,
    int? status,
  }) =>
      Items(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        token: token ?? this.token,
        status: status ?? this.status,
      );

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        userId: json["userId"],
        email: json["email"],
        token: json["token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "token": token,
        "status": status,
      };
}
