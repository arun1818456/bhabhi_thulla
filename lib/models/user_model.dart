class UserDataModel {
  String? id;
  String? name;
  String? email;
  String? token;
  String? deviceToken;
  String? profileUrl;
  int? balance;
   UserDataModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.deviceToken,
    this.profileUrl,
    this.balance,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    deviceToken = json['deviceToken'].toString();
    profileUrl = json['profileUrl'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['deviceToken'] = deviceToken;
    data['profileUrl'] = profileUrl;
    data['balance'] = balance;
    return data;
  }
}
