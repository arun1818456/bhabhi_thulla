
import '../../constant/export_file.dart';

class GameController extends GetxController {
  int players = 2;
  List onTableThrowCards = [];
  final List<List<dynamic>> handCards = [
    [5, Suit.diamonds],
    [11, Suit.hearts],
    [12, Suit.hearts],
    [13, Suit.clubs],
    [3, Suit.spades],
    [4, Suit.hearts],
    [4, Suit.clubs],
    [5, Suit.spades],
    [6, Suit.spades],
    [7, Suit.hearts],
    [12, Suit.hearts],
  ];

  @override
  void onInit() {
    startGame();
    super.onInit();
  }

  void startGame() {}
}
