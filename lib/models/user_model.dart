class UserDataModel {
  String? id;
  String? name;
  String? email;
  String? token;
  String? deviceToken;
  String? profileUrl;
  String? avatar;
  String? createdAt;
  int? coins;
  int? diamonds;
   UserDataModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.deviceToken,
    this.profileUrl,
    this.coins,
    this.diamonds,
    this.avatar,
    this.createdAt,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    deviceToken = json['deviceToken'].toString();
    profileUrl = json['profileUrl'];
    coins = json['coins'];
    diamonds = json['diamonds'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['deviceToken'] = deviceToken;
    data['profileUrl'] = profileUrl;
    data['coins'] = coins;
    data['diamonds'] = diamonds;
    data['avatar'] = avatar;
    data['createdAt'] = createdAt;
    return data;
  }
}
