import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:bhabhi_thulla/models/game_room_model.dart';

class SoloRoomController extends GetxController {
  int? prizeSelected;
  bool findPlayer = false;
  bool matching = false;

  void startMatching() {
    findPlayer = true;
    update();
  }

   void onTapToSelectPrize(int prize) {
    prizeSelected = prize;
    update();
  }

  /// variables
  final List<GameRoom> rooms = [
    GameRoom(prize: 160, entryFee: 120),
    GameRoom(prize: 380, entryFee: 300),
    GameRoom(prize: 760, entryFee: 600),
    GameRoom(prize: 1500, entryFee: 1200),
    GameRoom(prize: 3200, entryFee: 2500),
    GameRoom(prize: 6500, entryFee: 5200),
  ];
}
