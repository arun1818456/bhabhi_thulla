
import 'package:bhabhi_thulla/constant/export_file.dart';

class GameController extends GetxController{
  int players =2;
  List onTableThrowCards=[];
  final List<List<dynamic>> handCards = [
    ["5", "♦", Colors.red],
    ["J", "♣", Colors.black],
    ["K", "♣", Colors.black],
    ["3", "♥", Colors.red],
    ["4", "♥", Colors.red],
    ["4", "♠", Colors.black],
    ["5", "♠", Colors.black],
    ["6", "♠", Colors.black],
    ["7", "♠", Colors.black],
    ["8", "♠", Colors.black],  ["5", "♦", Colors.red],
    ["J", "♣", Colors.black],
    ["K", "♣", Colors.black],
    ["3", "♥", Colors.red],
    ["4", "♥", Colors.red],
    ["4", "♠", Colors.black],
    ["5", "♠", Colors.black],
    ["6", "♠", Colors.black],
    ["7", "♠", Colors.black],
    ["8", "♠", Colors.black],  ["5", "♦", Colors.red],
    ["J", "♣", Colors.black],
    ["K", "♣", Colors.black],
    ["3", "♥", Colors.red],
    ["4", "♥", Colors.red],
    ["4", "♠", Colors.black],
    ["5", "♠", Colors.black],
    ["6", "♠", Colors.black],
    ["7", "♠", Colors.black],
    ["8", "♠", Colors.black],
  ];

  @override
  void onInit() {
    startGame();
    super.onInit();
  }

 void  startGame(){

  }

}