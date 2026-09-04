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

  UserDataModel.fromJson(Map<dynamic, dynamic> rawJson) {
    Map<String, dynamic> json = Map<String, dynamic>.from(rawJson);

    // Check if user object is nested inside 'user' or 'userId' field
    if (json['user'] is Map) {
      json = Map<String, dynamic>.from(json['user']);
    } else if (json['userId'] is Map) {
      json = Map<String, dynamic>.from(json['userId']);
    }

    id = json['_id']?.toString() ??
        json['id']?.toString() ??
        json['userId']?.toString();
    pid = json['pid'] is int
        ? json['pid']
        : int.tryParse(json['pid']?.toString() ?? '');
    flag = json['flag']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    token = json['token']?.toString();
    deviceToken = json['deviceToken']?.toString();
    profileUrl = json['profileUrl']?.toString();
    coins = json['coins'] is int
        ? json['coins']
        : int.tryParse(json['coins']?.toString() ?? '');
    diamonds = json['diamonds'] is int
        ? json['diamonds']
        : int.tryParse(json['diamonds']?.toString() ?? '');
    avatar = json['avatar']?.toString();
    createdAt = json['createdAt']?.toString();
    level = json['level'] is int
        ? json['level']
        : int.tryParse(json['level']?.toString() ?? '');
    isOnline = json['isOnline'] == true;
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
