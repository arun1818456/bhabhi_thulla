import '../../constant/export_file.dart';

class GameController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();
  int? playersCount;
  int? mySeat;
  String? roomId;
  int? entryFee;
  int? currentTurn;
  bool firstChal = false;
  String? currentSuitChal;
  List<Map> tableCards = [];
  List<Map> handCards = [];
  List players = [];

  Function(Map data)? onCardPlayedReceived;

  bool get isMyTurn =>
      (mySeat != null && currentTurn != null && mySeat == currentTurn);

  @override
  void onInit() {
    socketController.socket.value?.on('card_played', cardPlayed);
    socketController.socket.value?.on('turn_changed', turnChanged);
    socketController.socket.value?.on('table_cleared', tableCleared);
    socketController.socket.value?.on('your_cards', yourCards);
    super.onInit();
  }

  @override
  void onClose() {
    socketController.socket.value?.off('card_played');
    socketController.socket.value?.off('turn_changed');
    super.onClose();
  }

  Suit? get activeSuit {
    if (currentSuitChal != null && currentSuitChal!.isNotEmpty) {
      return parseSuit(currentSuitChal);
    }
    if (tableCards.isNotEmpty) {
      final firstCard = tableCards.first;
      if (firstCard["suit"] != null) {
        return parseSuit(firstCard["suit"]);
      }
    }
    return null;
  }

  bool get hasCurrentSuitCard {
    final suit = activeSuit;
    if (suit == null) return false;
    return handCards.any((card) => parseSuit(card["suit"]) == suit);
  }

  bool isCardPlayable(Map card) {
    if (!isMyTurn) return false;

    // First Chal Rule: Must play Ace of Spades if present in hand
    if (firstChal) {
      final int rank = parseRank(card["rank"] ?? card["value"]);
      final Suit suit = parseSuit(card["suit"]);
      if (rank == 1 && suit == Suit.spades) {
        return true;
      }
      final bool hasAceOfSpades = handCards.any(
        (c) =>
            parseRank(c["rank"] ?? c["value"]) == 1 &&
            parseSuit(c["suit"]) == Suit.spades,
      );
      if (hasAceOfSpades) {
        return false;
      }
    }

    final suit = activeSuit;
    if (suit == null) return true;
    if (hasCurrentSuitCard) {
      return parseSuit(card["suit"]) == suit;
    }
    return true;
  }

  void sortHandCards() {
    if (handCards.isEmpty) return;

    int suitOrder(Suit suit) {
      switch (suit) {
        case Suit.hearts:
          return 1;
        case Suit.diamonds:
          return 2;
        case Suit.spades:
          return 3;
        case Suit.clubs:
          return 4;
      }
    }

    handCards.sort((a, b) {
      final Suit suitA = parseSuit(a["suit"]);
      final Suit suitB = parseSuit(b["suit"]);

      final int orderA = suitOrder(suitA);
      final int orderB = suitOrder(suitB);

      if (orderA != orderB) {
        return orderA.compareTo(orderB);
      }

      final int rankA = parseRank(a["rank"] ?? a["value"]);
      final int rankB = parseRank(b["rank"] ?? b["value"]);

      final int adjustedRankA = rankA == 1 ? 14 : rankA;
      final int adjustedRankB = rankB == 1 ? 14 : rankB;

      return adjustedRankB.compareTo(adjustedRankA);
    });

    update();
  }

  String get currentSuitName {
    final suit = activeSuit;
    if (suit == null) return "";
    switch (suit) {
      case Suit.spades:
        return "Spades";
      case Suit.hearts:
        return "Hearts";
      case Suit.diamonds:
        return "Diamonds";
      case Suit.clubs:
        return "Clubs";
    }
  }

  void cardPlayed(dynamic data) {
    if (tableCards.isEmpty) {
      currentSuitChal = data["card"]?["suit"]?.toString();
    }
    debugPrint(">>cardPlayed >>> $data");
    if (data != null && data is Map) {
      final Map mapData = Map.from(data);
      if (onCardPlayedReceived != null) {
        onCardPlayedReceived!(mapData);
      }
    }
  }

  void yourCards(dynamic data) {
    debugPrint(">>yourCards >>> $data");
    if (data != null && data is Map && roomId == data["roomId"]) {
      final dynamic rawHandCards = data["cards"];
      if (rawHandCards != null && rawHandCards is List) {
        handCards = (rawHandCards)
            .map(
              (e) => e is Map
                  ? Map<String, dynamic>.from(e)
                  : e is List
                  ? {"rank": parseRank(e[0]), "suit": e[1]}
                  : <String, dynamic>{},
            )
            .toList();
      } else {
        handCards = [];
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

  void tableCleared(dynamic data) {
    debugPrint(">>tableCleared >>> $data");
    if (data != null && data is Map && roomId == data["roomId"]) {
      tableCards = [];
      currentSuitChal = null;
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
