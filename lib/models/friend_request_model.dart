import 'package:bhabhi_thulla/constant/export_file.dart';

class FriendRequestModel {
  String? sId;
  UserDataModel? senderId;
  String? receiverId;
  String? status;
  String? createdAt;
  String? updatedAt;

  FriendRequestModel({
    this.sId,
    this.senderId,
    this.receiverId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  FriendRequestModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'] != null
        ? UserDataModel.fromJson(json['senderId'])
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
