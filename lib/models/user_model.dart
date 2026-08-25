class UserDataModel {
  String? id;
  int? pid;
  String? name;
  String? email;
  String? token;
  String? deviceToken;
  String? profileUrl;
  String? avatar;
  String? flag;
  String? createdAt;
  int? coins;
  int? diamonds;
  int? level;
  bool? isOnline;

  UserDataModel({
    this.id,
    this.pid,
    this.flag,
    this.name,
    this.email,
    this.token,
    this.deviceToken,
    this.profileUrl,
    this.coins,
    this.diamonds,
    this.avatar,
    this.createdAt,
    this.level,
    this.isOnline,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? json['id'];
    pid = json['pid'];
    flag = json['flag'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    deviceToken = json['deviceToken'].toString();
    profileUrl = json['profileUrl'];
    coins = json['coins'];
    diamonds = json['diamonds'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    level = json['level'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['pid'] = pid;
    data['flag'] = flag;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['deviceToken'] = deviceToken;
    data['profileUrl'] = profileUrl;
    data['coins'] = coins;
    data['diamonds'] = diamonds;
    data['avatar'] = avatar;
    data['createdAt'] = createdAt;
    data['level'] = level;
    data['isOnline'] = isOnline;
    return data;
  }
}
