class UserModel {
  UserModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });
  late final bool status;
  late final int subCode;
  late final String message;
  late final String error;
  late final UserData items;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = UserData.fromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['subCode'] = subCode;
    data['message'] = message;
    data['error'] = error;
    data['items'] = items.toJson();
    return data;
  }
}

class UserData {
  UserData({
    required this.id,
    required this.pilotName,
    required this.email,
    required this.password,
    required this.pilotCode,
    required this.V,
    required this.match_number,
    required this.round_number,
  });
  late final String id;
  late final String pilotName;
  late final String email;
  late final String password;
  late final int pilotCode;
  late final int match_number;
  late final int round_number;
  late final int V;

  UserData.fromJson(Map<String, dynamic> json) {
    match_number = json['match_number'] ?? 0;
    round_number = json['round_number'] ?? 0;
    id = json['_id'];
    pilotName = json['pilotName'];
    email = json['email'];
    password = json['password'];
    pilotCode = json['pilotCode'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['round_number'] = round_number;
    data['match_number'] = match_number;
    data['_id'] = id;
    data['pilotName'] = pilotName;
    data['email'] = email;
    data['password'] = password;
    data['pilotCode'] = pilotCode;
    data['__v'] = V;
    return data;
  }
}
