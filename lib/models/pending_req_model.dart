class PendingRequestModel {
  String? sId;
  SenderId? senderId;
  String? receiverId;
  String? status;
  String? createdAt;
  String? updatedAt;

  PendingRequestModel({
    this.sId,
    this.senderId,
    this.receiverId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PendingRequestModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'] != null
        ? SenderId.fromJson(json['senderId'])
        : null;
    receiverId = json['receiverId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (senderId != null) {
      data['senderId'] = senderId!.toJson();
    }
    data['receiverId'] = receiverId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SenderId {
  String? sId;
  int? pid;
  String? name;
  String? avatar;
  String? flag;
  int? level;

  SenderId({this.sId, this.name, this.avatar, this.flag, this.level, this.pid});

  SenderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pid = json['pid'];
    name = json['name'];
    avatar = json['avatar'];
    flag = json['flag'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['pid'] = pid;
    data['avatar'] = avatar;
    data['flag'] = flag;
    data['level'] = level;
    return data;
  }
}
