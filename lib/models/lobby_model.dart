import 'package:bhabhi_thulla/constant/export_file.dart';

class LobbyModel {
  String? lobbyId;
  String? ownerId;
  int? entryFee;
  int? playersCount;
  List<UserDataModel>? players;
  String? status;
  int? coins;

  LobbyModel({
    this.lobbyId,
    this.ownerId,
    this.entryFee,
    this.playersCount,
    this.players,
    this.status,
    this.coins,
  });

  factory LobbyModel.fromJson(Map<dynamic, dynamic> rawJson) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(rawJson);
    return LobbyModel(
      lobbyId: json["lobbyId"]?.toString(),
      ownerId: json["ownerId"]?.toString(),
      entryFee: json["entryFee"] is int
          ? json["entryFee"]
          : int.tryParse(json["entryFee"]?.toString() ?? ''),
      playersCount: json["playersCount"] is int
          ? json["playersCount"]
          : int.tryParse(json["playersCount"]?.toString() ?? ''),
      players: (json["players"] as List<dynamic>?)
          ?.map((e) => UserDataModel.fromJson(
              e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map)))
          .toList(),
      status: json["status"]?.toString(),
      coins: json["coins"] is int
          ? json["coins"]
          : int.tryParse(json["coins"]?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lobbyId": lobbyId,
      "ownerId": ownerId,
      "entryFee": entryFee,
      "playersCount": playersCount,
      "players": players?.map((e) => e.toJson()).toList(),
      "status": status,
      "coins": coins,
    };
  }
}

class PlayerModel {
  String? userId;
  String? name;
  String? socketId;
  int? seat;

  PlayerModel({
    this.userId,
    this.name,
    this.socketId,
    this.seat,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      userId: json["userId"],
      name: json["name"],
      socketId: json["socketId"],
      seat: json["seat"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "socketId": socketId,
      "seat": seat,
    };
  }
}