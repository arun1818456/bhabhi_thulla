class UserDataModel {
  String? name;
  String? userName;
  String? uid;
  String? profileUrl;
  String? coins;
  String? deviceToken;
  String? passKey;
  String? email;
  String? totalFriends;

  UserDataModel(
      {this.uid,
        this.name,
        this.userName,
        this.email,
        this.profileUrl,
        this.deviceToken,
        this.coins,
        this.passKey,
        this.totalFriends
      });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['user_name'];
    coins = json['coins'];
    name = json['name'];
    email = json['email'];
    profileUrl = json['profile_url'];
    deviceToken = json['device_token'];
    passKey = json['pass_key'];
    totalFriends = json['total_friends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['user_name'] = userName;
    data['coins'] = coins;
    data['name'] = name;
    data['email'] = email;
    data['profile_url'] = profileUrl;
    data['device_token'] = deviceToken;
    data['pass_key'] = passKey;
    data['total_friends'] = totalFriends;
    return data;
  }
}
