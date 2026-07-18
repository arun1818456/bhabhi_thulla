import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bhabhi_thulla/constant/lists.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../../constant/user_data.dart';

class TwoPlayerController extends GetxController {
  List droppedCardsList = [];
  List<Map> player1 = [];
  List player2 = [];
  List deck = [];
  int turn = 0;
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    shufflingDeck();
  }

  shufflingDeck() async {
    deck = [];
    for (var suit in suits) {
      for (var rank in ranks) {
        deck.add({"suit": suit, "value": rank});
      }
    }
    deck.shuffle(Random());
    // checking Spade of ace is compulsory to add first turn
    for (var element in deck) {
      if (element["suit"] == Suit.spades && element["value"] == CardValue.ace) {
        deck.removeWhere((element) =>
            element["suit"] == Suit.spades &&
            element["value"] == CardValue.ace);
        DateTime currentTime = DateTime.now();
        if (currentTime.second % 2 == 0) {
          deck.insert(0, {"suit": Suit.spades, "value": CardValue.ace});
        } else {
          deck.insert(14, {"suit": Suit.spades, "value": CardValue.ace});
        }
      }
    }

    ///
    var p1 = deck.sublist(0, 13);
    var p2 = deck.sublist(13, 26);
    for (var element in p1) {
      player1.add({"suit": element["suit"], "value": element["value"]});
    }
    for (var element in p2) {
      player2.add({"suit": element["suit"], "value": element["value"]});
    }

    // checking if Spade Card ace is giving chaal automatically
    List toRemove = [];
    for (var element in player1) {
      if (element["suit"] == Suit.spades && element["value"] == CardValue.ace) {
        droppedCardsList.add(
            {"suit": Suit.spades, "value": CardValue.ace, "player": "player1"});
        toRemove.add(element); // Collect elements to remove
        turn = 2;
      }
    }
    player1.removeWhere((e) => toRemove.contains(e));
    for (var element in player2) {
      if (element["suit"] == Suit.spades && element["value"] == CardValue.ace) {
        droppedCardsList.add(
            {"suit": Suit.spades, "value": CardValue.ace, "player": "player2"});
        toRemove.add(element); // Collect elements to remove
        turn = 1;
      }
    }
    player2.removeWhere((e) => toRemove.contains(e));
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();
    await dbRef
        .child("two_player/${UserData.uid}/data/")
        .push()
        .set({})
        .then(
          (value) {},
        )
        .onError(
          (error, stackTrace) {
            // Message().toast("$error", error: true);
          },
        );
  }
}
