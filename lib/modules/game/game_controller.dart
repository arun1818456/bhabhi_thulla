import '../../constant/export_file.dart';

class GameController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();
  int? playersCount;
  int? mySeat;
  String? roomId;
  int? entryFee;
  int? currentTurn;
  List<Map> tableCards = [];
  List<Map> handCards = [];
  List players = [];

  Function(Map data)? onCardPlayedReceived;

  bool get isMyTurn =>
      (mySeat != null && currentTurn != null && mySeat == currentTurn);

  @override
  void onInit() {
    startGame();
    socketController.socket.value?.on('card_played', cardPlayed);
    socketController.socket.value?.on('turn_changed', turnChanged);
    super.onInit();
  }

  @override
  void onClose() {
    socketController.socket.value?.off('card_played');
    socketController.socket.value?.off('turn_changed');
    super.onClose();
  }

  void startGame() {}

  void cardPlayed(dynamic data) {
    debugPrint(">>cardPlayed >>> $data");
    if (data != null && data is Map) {
      final Map mapData = Map.from(data);
      if (onCardPlayedReceived != null) {
        onCardPlayedReceived!(mapData);
      }
    }
  }

  void turnChanged(dynamic data) {
    debugPrint(">>turnChanged >>> $data");
    if (data != null && data is Map && roomId == data["roomId"]) {
      currentTurn = data["currentTurn"];
      update();
    }
  }

  void onPlayCardEmit(Map card) {
    final int rank = parseRank(card["rank"] ?? card["value"]);
    final String suitStr = card["suit"] is Suit
        ? (card["suit"] as Suit).name
        : card["suit"]?.toString() ?? "spades";

    Map data = {
      "roomId": roomId,
      "card": {"rank": rank, "suit": suitStr},
    };
    debugPrint(">>>> play_card emit: $data");
    socketController.socket.value?.emit("play_card", data);
  }
}
