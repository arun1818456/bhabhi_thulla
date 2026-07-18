import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';






///////////////////________TWO P_S_________/
class Player2 extends StatefulWidget {
  const Player2({super.key});

  @override
  State<Player2> createState() => _Player2State();
}

class _Player2State extends State<Player2> {
  PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(
    suitStyles: {
      Suit.spades: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♠",
            style: TextStyle(fontSize: 900),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.hearts: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♥",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.diamonds: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♦",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.clubs: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♣",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.joker: SuitStyle(builder: (context) => Container()),
    },
  );
  final List<CardValue> ranks = [
    CardValue.ace,
    CardValue.two,
    CardValue.three,
    CardValue.four,
    CardValue.five,
    CardValue.six,
    CardValue.seven,
    CardValue.eight,
    CardValue.nine,
    CardValue.ten,
    CardValue.jack,
    CardValue.queen,
    CardValue.king
  ];
  final List<Suit> suits = [
    Suit.spades,
    Suit.hearts,
    Suit.diamonds,
    Suit.clubs
  ];
  var roundingCard;
  bool tholla = false;
  List droppedCardsList = [];
  List deck = [];
  List<Map> player1 = [];
  List player2 = [];
  int turn = 0;
  int counter = 10;
  late Timer _timer;
  bool sideDeckShow = false;
  @override
  void initState() {
    super.initState();
    shufflingDeck();
    roundingCard = Suit.spades;
    startTimer();
  }

  bool once = false;
  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (counter == 0) {
          _timer.cancel();
          automaticCardThrown();
        } else {
          counter--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  shufflingDeck() {
    if (kDebugMode) {
      print("shufflingDeck");
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            "${player1.length}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                      if (turn == 1)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text(
                                "$counter",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Player1"),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              /*MultiIWidget(
                cardHeight: 70,
                backShow: true,
                suit: const [
                  Suit.spades,
                  Suit.clubs,
                  Suit.diamonds,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                  Suit.hearts,
                ],
                value: const [
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                  CardValue.ace,
                ],
                myCardStyles: myCardStyles,
              ),*/
              Container(
                decoration: turn == 1
                    ? const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.red, width: 2),
                            right: BorderSide(color: Colors.red, width: 2),
                            top: BorderSide(color: Colors.red, width: 2)))
                    : null,
                child: SizedBox(
                  height: 75,
                  width: 50 + player1.length * 35,
                  child: Stack(
                    children: List.generate(player1.length, (index) {
                      return Positioned(
                        left: 35.0 * index,
                        child: SizedBox(
                          width: 80,
                          height: 135,
                          child: GestureDetector(
                            onTap: turn == 1
                                ? () async {
                                    try {
                                      bool myFirstCars = false;
                                      if (roundingCard == null &&
                                          myFirstCars == false) {
                                        _timer.cancel();
                                        setState(() {
                                          droppedCardsList.add({
                                            "suit": player1[index]["suit"],
                                            "value": player1[index]["value"],
                                            "player": "player1"
                                          });
                                          roundingCard = player1[index]["suit"];
                                          myFirstCars = true;
                                          player1.removeAt(index);
                                        });
                                        bool cardHai = false;
                                        for (var element in player2) {
                                          if (element["suit"] == roundingCard) {
                                            setState(() {
                                              cardHai = true;
                                            });
                                            break;
                                          }
                                        }
                                        if (cardHai == false) {
                                          tholla = true;
                                        }
                                        setState(() {
                                          turn = 2;
                                          startTimer();
                                          counter = 10;
                                        });
                                      }
                                      //  ////tholla card Thrown
                                      if (tholla == true &&
                                          myFirstCars == false) {
                                        setState(() {
                                          _timer.cancel();
                                          droppedCardsList.add({
                                            "suit": player1[index]["suit"],
                                            "value": player1[index]["value"],
                                            "player": "player1"
                                          });
                                          player1.removeAt(index);
                                        });
                                        if (droppedCardsList.length == 2) {
                                          await Future.delayed(
                                              const Duration(seconds: 1), () {
                                            for (var element
                                                in droppedCardsList) {
                                              player2.add(element);
                                            }
                                            setState(() {
                                              roundingCard = null;
                                              droppedCardsList.clear();
                                              turn = 2;
                                              tholla = false;
                                              startTimer();
                                              counter = 10;
                                            });
                                          });
                                        }
                                      }
                                      if (roundingCard ==
                                              player1[index]["suit"] &&
                                          roundingCard != null &&
                                          myFirstCars == false &&
                                          tholla == false) {
                                        setState(() {
                                          _timer.cancel();
                                          droppedCardsList.add({
                                            "suit": player1[index]["suit"],
                                            "value": player1[index]["value"],
                                            "player": "player1"
                                          });
                                          player1.removeAt(index);
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 2), () {
                                          checkingTurn();
                                          setState(() {
                                            sideDeckShow = true;
                                            startTimer();
                                            counter = 10;
                                          });
                                        });
                                      }
                                      // changing Turn
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    }
                                  }
                                : () {},
                            child: PlayingCardView(
                              shape: ShapeBorder.lerp(
                                  Border.all(
                                      color: player1[index]["suit"] ==
                                                  roundingCard &&
                                              turn == 1
                                          ? Colors.green
                                          : Colors.black,
                                      width: player1[index]["suit"] ==
                                                  roundingCard &&
                                              turn == 1
                                          ? 1.5
                                          : 0.5),
                                  Border.all(),
                                  0.0),
                              elevation: 10,
                              card: PlayingCard(player1[index]["suit"],
                                  player1[index]["value"]),
                              style: myCardStyles,
                              showBack: false,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: /*MediaQuery.of(context).size.width*0.15*/ 200,
                // color: Colors.green,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    if (droppedCardsList.length == 1 ||
                        droppedCardsList.length == 2)
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(90 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            elevation: 10,
                            card: PlayingCard(droppedCardsList[0]["suit"],
                                droppedCardsList[0]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    if (droppedCardsList.length == 2)
                      Positioned(
                        top: 0,
                        left: 30,
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[1]["suit"],
                                droppedCardsList[1]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              if (sideDeckShow)
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  alignment: Alignment.centerRight,
                  height: 70,
                  child: PlayingCardView(
                    shape: ShapeBorder.lerp(
                        Border.all(color: Colors.black), Border.all(), 0.1),
                    elevation: 10,
                    card: PlayingCard(Suit.joker, CardValue.joker_1),
                    showBack: true,
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            "${player2.length}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                      if (turn == 2)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text(
                                "$counter",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Player2"),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              const SizedBox(
                width: 18,
              ),
              Container(
                decoration: turn == 2
                    ? const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.red),
                            right: BorderSide(color: Colors.red),
                            top: BorderSide(color: Colors.red)))
                    : null,
                child: SizedBox(
                  height: 75,
                  width: 50 + player2.length * 35,
                  child: Stack(
                    children: List.generate(player2.length, (index) {
                      return Positioned(
                        left: 35.0 * index,
                        child: SizedBox(
                          width: 80,
                          height: 135,
                          child: GestureDetector(
                            onTap: turn == 2
                                ? () async {
                                    try {
                                      bool myFirstCars = false;
                                      if (roundingCard == null &&
                                          myFirstCars == false) {
                                        _timer.cancel();
                                        setState(() {
                                          droppedCardsList.add({
                                            "suit": player2[index]["suit"],
                                            "value": player2[index]["value"],
                                            "player": "player2"
                                          });
                                          roundingCard = player2[index]["suit"];
                                          myFirstCars = true;
                                          player2.removeAt(index);
                                        });
                                        bool cardHai = false;
                                        for (var element in player1) {
                                          if (element["suit"] == roundingCard) {
                                            setState(() {
                                              cardHai = true;
                                            });
                                            break;
                                          }
                                        }
                                        if (cardHai == false) {
                                          tholla = true;
                                        }
                                        setState(() {
                                          turn = 1;
                                          startTimer();
                                          counter = 10;
                                        });
                                      }
                                      //  ////tholla card Thrown
                                      if (tholla == true &&
                                          myFirstCars == false) {
                                        setState(() {
                                          _timer.cancel();
                                          droppedCardsList.add({
                                            "suit": player2[index]["suit"],
                                            "value": player2[index]["value"],
                                            "player": "player2"
                                          });
                                          player2.removeAt(index);
                                        });
                                        if (droppedCardsList.length == 2) {
                                          await Future.delayed(
                                              const Duration(seconds: 1), () {
                                            for (var element
                                                in droppedCardsList) {
                                              player1.add(element);
                                            }
                                            setState(() {
                                              roundingCard = null;
                                              droppedCardsList.clear();
                                              turn = 1;
                                              tholla = false;
                                              startTimer();
                                              counter = 10;
                                            });
                                          });
                                        }
                                      }
                                      /////
                                      if (roundingCard ==
                                              player2[index]["suit"] &&
                                          roundingCard != null &&
                                          myFirstCars == false &&
                                          tholla == false) {
                                        setState(() {
                                          _timer.cancel();
                                          droppedCardsList.add({
                                            "suit": player2[index]["suit"],
                                            "value": player2[index]["value"],
                                            "player": "player2"
                                          });
                                          player2.removeAt(index);
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 2), () {
                                          checkingTurn();
                                          setState(() {
                                            sideDeckShow = true;
                                            startTimer();
                                            counter = 10;
                                          });
                                        });
                                      }
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    }
                                  }
                                : () {},
                            child: PlayingCardView(
                              shape: ShapeBorder.lerp(
                                  Border.all(
                                      color: player2[index]["suit"] ==
                                                  roundingCard &&
                                              turn == 2
                                          ? Colors.green
                                          : Colors.black,
                                      width: player2[index]["suit"] ==
                                                  roundingCard &&
                                              turn == 2
                                          ? 1.5
                                          : 0.5),
                                  Border.all(),
                                  0.0),
                              elevation: 10,
                              card: PlayingCard(player2[index]["suit"],
                                  player2[index]["value"]),
                              style: myCardStyles,
                              showBack: false,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  List dummy = [];
                  for (var element in player2) {
                    if (element["suit"] == Suit.spades) {
                      dummy.add(element);
                    }
                  }
                  for (var element in player2) {
                    if (element["suit"] == Suit.diamonds) {
                      dummy.add(element);
                    }
                  }
                  for (var element in player2) {
                    if (element["suit"] == Suit.clubs) {
                      dummy.add(element);
                    }
                  }
                  for (var element in player2) {
                    if (element["suit"] == Suit.hearts) {
                      dummy.add(element);
                    }
                  }
                  setState(() {
                    player2 = dummy;
                  });
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Center(
                      child: Text(
                    "Set Cards",
                    style: TextStyle(fontSize: 8),
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void checkingTurn() {
    List cardValues = [];
    List cardValuesNumbers = [];
    for (var element in droppedCardsList) {
      cardValues.add(element["value"]);
    }
    for (var element in cardValues) {
      if (element == CardValue.ace) {
        cardValuesNumbers.add(14);
      } else if (element == CardValue.two) {
        cardValuesNumbers.add(2);
      } else if (element == CardValue.three) {
        cardValuesNumbers.add(3);
      } else if (element == CardValue.four) {
        cardValuesNumbers.add(4);
      } else if (element == CardValue.five) {
        cardValuesNumbers.add(5);
      } else if (element == CardValue.six) {
        cardValuesNumbers.add(6);
      } else if (element == CardValue.seven) {
        cardValuesNumbers.add(7);
      } else if (element == CardValue.eight) {
        cardValuesNumbers.add(8);
      } else if (element == CardValue.nine) {
        cardValuesNumbers.add(9);
      } else if (element == CardValue.ten) {
        cardValuesNumbers.add(10);
      } else if (element == CardValue.jack) {
        cardValuesNumbers.add(11);
      } else if (element == CardValue.queen) {
        cardValuesNumbers.add(12);
      } else if (element == CardValue.king) {
        cardValuesNumbers.add(13);
      }
    }
    int maxIndex = cardValuesNumbers
        .indexOf(cardValuesNumbers.reduce((a, b) => a > b ? a : b));
    for (var element in droppedCardsList) {
      if (element["value"] == cardValues[maxIndex]) {
        if (element["player"] == "player1") {
          turn = 1;
        } else if (element["player"] == "player2") {
          turn = 2;
        }
      }
    }
    setState(() {
      roundingCard = null;
      droppedCardsList.clear();
    });
  }

  automaticCardThrown() async {
    try {
      if (turn == 1) {
        bool myFirstCars = false;
        //if dropped card is empty
        if (roundingCard == null && myFirstCars == false) {
          setState(() {
            droppedCardsList.add({
              "suit": player1[0]["suit"],
              "value": player1[0]["value"],
              "player": "player2"
            });
            roundingCard = player1[0]["suit"];
            myFirstCars = true;
            player1.removeAt(0);
          });
          bool cardHai = false;
          for (var element in player2) {
            if (element["suit"] == roundingCard) {
              setState(() {
                cardHai = true;
              });
              break;
            }
          }
          if (cardHai == false) {
            tholla = true;
          }
          setState(() {
            turn = 2;
            counter = 10;
            startTimer();
          });
        }
        //  ////tholla card Thrown
        if (tholla == true && myFirstCars == false) {
          setState(() {
            droppedCardsList.add({
              "suit": player1[0]["suit"],
              "value": player1[0]["value"],
              "player": "player2"
            });
          });
          player1.remove(player1[0]);
          if (droppedCardsList.length == 2) {
            await Future.delayed(const Duration(seconds: 1), () {
              for (var element in droppedCardsList) {
                player2.add(element);
              }
              setState(() {
                roundingCard = null;
                droppedCardsList.clear();
                turn = 2;
                tholla = false;
                startTimer();
                counter = 10;
              });
            });
          }
        }

        // if dropped card and turn is mine   not tholla
        if (roundingCard != null && myFirstCars == false && tholla == false) {
          for (var i = 0; i < player1.length; i++) {
            if (player1[i]["suit"] == roundingCard) {
              setState(() {
                droppedCardsList.add({
                  "suit": player1[i]["suit"],
                  "value": player1[i]["value"],
                  "player": "player1"
                });
              });
              // Remove the specific card from player2
              player1.removeAt(i);
              break; // Break after removing the first matching card
            }
          }
          await Future.delayed(const Duration(seconds: 2), () {
            checkingTurn();
            setState(() {
              sideDeckShow = true;
              counter = 10;
              startTimer();
            });
          });
        }
      } else if (turn == 2) {
        bool myFirstCars = false;

        // //if dropped card is empty
        if (roundingCard == null && myFirstCars == false && tholla == false) {
          setState(() {
            droppedCardsList.add({
              "suit": player2[0]["suit"],
              "value": player2[0]["value"],
              "player": "player2"
            });
            roundingCard = player2[0]["suit"];
            myFirstCars = true;
            player2.remove(player2[0]);
          });
          bool cardHai = false;
          for (var element in player1) {
            if (element["suit"] == roundingCard) {
              setState(() {
                cardHai = true;
              });
              break;
            }
          }
          if (cardHai == false) {
            tholla = true;
          }
          setState(() {
            turn = 1;
            counter = 10;
            startTimer();
          });
        }
        //  ////tholla card Thrown
        if (tholla == true && myFirstCars == false) {
          setState(() {
            droppedCardsList.add({
              "suit": player2[0]["suit"],
              "value": player2[0]["value"],
              "player": "player2"
            });
          });
          player2.remove(player2[0]);

          if (droppedCardsList.length == 2) {
            await Future.delayed(const Duration(seconds: 1), () {
              for (var element in droppedCardsList) {
                player1.add(element);
              }
              setState(() {
                roundingCard = null;
                droppedCardsList.clear();
                turn = 1;
                tholla = false;
                startTimer();
                counter = 10;
              });
            });
          }
        }

        // // if dropped card and turn is mine   not tholla
        if (roundingCard != null && myFirstCars == false && tholla == false) {
          for (var i = 0; i < player2.length; i++) {
            if (player2[i]["suit"] == roundingCard) {
              setState(() {
                droppedCardsList.add({
                  "suit": player2[i]["suit"],
                  "value": player2[i]["value"],
                  "player": "player2"
                });
              });
              player2.removeAt(i);
              break;
            }
          }
          await Future.delayed(const Duration(seconds: 2), () {
            checkingTurn();
            setState(() {
              sideDeckShow = true;
              startTimer();
            });
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

///////////////////________THREE P_S_________///////////////////////////////////

class ThreePlayers extends StatefulWidget {
  const ThreePlayers({super.key});

  @override
  State<ThreePlayers> createState() => _ThreePlayersState();
}

class _ThreePlayersState extends State<ThreePlayers> {
  List droppedCardsList = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player1 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player2 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player3 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
  ];

  //////play Turn
  var roundingCard;
  bool tholla = false;
  List deck = [];
  int turn = 0;
  int counter = 10;
  late Timer _timer;
  bool sideDeckShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 150,
                  width: 200,
                  margin: const EdgeInsets.only(left: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "${player1.length}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                              if (turn == 1)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Text(
                                        "$counter",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text("Player1"),
                              Text(
                                "20000",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: turn == 1
                            ? const BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Colors.red),
                                    right: BorderSide(color: Colors.red),
                                    top: BorderSide(color: Colors.red)))
                            : null,
                        child: SizedBox(
                          height: 75,
                          width: 50 + player1.length * 35,
                          child: Stack(
                            children: List.generate(player1.length, (index) {
                              return Positioned(
                                left: 7.0 * index,
                                child: SizedBox(
                                  width: 40,
                                  height: 60,
                                  child: PlayingCardView(
                                    shape: ShapeBorder.lerp(
                                        Border.all(
                                            color: player1[index]["suit"] ==
                                                        roundingCard &&
                                                    turn == 1
                                                ? Colors.green
                                                : Colors.black,
                                            width: player1[index]["suit"] ==
                                                        roundingCard &&
                                                    turn == 1
                                                ? 1.5
                                                : 0.5),
                                        Border.all(),
                                        0.0),
                                    elevation: 10,
                                    card: PlayingCard(player1[index]["suit"],
                                        player1[index]["value"]),
                                    style: myCardStyles,
                                    showBack: true,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: 200,
                  margin: const EdgeInsets.only(right: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Column(
                            children: [
                              Text("Player2"),
                              Text(
                                "1500",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "${player2.length}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                              if (turn == 2)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Text(
                                        "$counter",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        decoration: turn == 2
                            ? const BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Colors.red),
                                    right: BorderSide(color: Colors.red),
                                    top: BorderSide(color: Colors.red)))
                            : null,
                        child: SizedBox(
                          height: 60,
                          width: 10 + player2.length * 35,
                          child: Stack(
                            children: List.generate(player2.length, (index) {
                              return Positioned(
                                left: 7.0 * index,
                                child: SizedBox(
                                  width: 40,
                                  height: 60,
                                  child: PlayingCardView(
                                    shape: ShapeBorder.lerp(
                                        Border.all(
                                            color: player2[index]["suit"] ==
                                                        roundingCard &&
                                                    turn == 2
                                                ? Colors.green
                                                : Colors.black,
                                            width: player2[index]["suit"] ==
                                                        roundingCard &&
                                                    turn == 2
                                                ? 1.5
                                                : 0.5),
                                        Border.all(),
                                        0.0),
                                    elevation: 10,
                                    card: PlayingCard(player2[index]["suit"],
                                        player2[index]["value"]),
                                    style: myCardStyles,
                                    showBack: true,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.green,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (droppedCardsList.length == 1 ||
                        droppedCardsList.length == 2 ||
                        droppedCardsList.length == 3)
                      Positioned(
                        left: 2,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(98 / 360),
                          child: SizedBox(
                            height: 160,
                            child: PlayingCardView(
                              shape: ShapeBorder.lerp(
                                  Border.all(color: Colors.black),
                                  Border.all(),
                                  0.1),
                              elevation: 10,
                              card: PlayingCard(droppedCardsList[0]["suit"],
                                  droppedCardsList[0]["value"]),
                              showBack: false,
                            ),
                          ),
                        ),
                      ),
                    if (droppedCardsList.length == 2 ||
                        droppedCardsList.length == 3)
                      Positioned(
                        top: 30,
                        right: 20,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(260 / 360),
                          child: SizedBox(
                            height: 160,
                            child: PlayingCardView(
                              shape: ShapeBorder.lerp(
                                  Border.all(color: Colors.black),
                                  Border.all(),
                                  0.1),
                              card: PlayingCard(droppedCardsList[1]["suit"],
                                  droppedCardsList[1]["value"]),
                              showBack: false,
                            ),
                          ),
                        ),
                      ),
                    if (droppedCardsList.length == 3)
                      Positioned(
                        top: 0,
                        child: SizedBox(
                          height: 160,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[2]["suit"],
                                droppedCardsList[2]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "${player3.length}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                              if (turn == 3)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Text(
                                        "$counter",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text("Player3"),
                              Text(
                                "16581",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: turn == 3
                          ? const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.red),
                                  right: BorderSide(color: Colors.red),
                                  top: BorderSide(color: Colors.red)))
                          : null,
                      child: SizedBox(
                        height: 85,
                        width: 50 + player3.length * 35,
                        child: Stack(
                          children: List.generate(player3.length, (index) {
                            return Positioned(
                              left: 35.0 * index,
                              child: SizedBox(
                                width: 80,
                                height: 135,
                                child: GestureDetector(
                                  /*onTap: turn == 2
                                      ? () async {
                                    try {
                                      bool myFirstCars = false;
                                      if (roundingCard == null &&
                                          myFirstCars == false) {
                                        _timer.cancel();
                                        setState(() {
                                          droppedCardsList.add({
                                            "suit": player2[index]["suit"],
                                            "value": player2[index]["value"],
                                            "player": "player2"
                                          });
                                          roundingCard = player2[index]["suit"];
                                          myFirstCars = true;
                                          player2.removeAt(index);
                                        });
                                        bool cardHai = false;
                                        for (var element in player1) {
                                          if (element["suit"] == roundingCard) {
                                            setState(() {
                                              cardHai = true;
                                            });
                                            break;
                                          }
                                        }
                                        if (cardHai == false) {
                                          tholla = true;
                                        }
                                        setState(() {
                                          turn = 1;
                                          // startTimer();
                                          counter = 10;
                                        });
                                      }
                                      //  ////tholla card Thrown
                                      if (tholla == true &&
                                          myFirstCars == false) {
                                        setState(() {
                                          _timer.cancel();
                                          droppedCardsList.add({
                                            "suit": player2[index]["suit"],
                                            "value": player2[index]["value"],
                                            "player": "player2"
                                          });
                                          player2.removeAt(index);
                                        });
                                        if (droppedCardsList.length == 2) {
                                          await Future.delayed(
                                              const Duration(seconds: 1), () {
                                            for (var element
                                            in droppedCardsList) {
                                              player1.add(element);
                                            }
                                            setState(() {
                                              roundingCard = null;
                                              droppedCardsList.clear();
                                              turn = 1;
                                              tholla = false;
                                              // startTimer();
                                              counter = 10;
                                            });
                                          });
                                        }
                                      }
                                      /////
                                      if (roundingCard ==
                                          player2[index]["suit"] &&
                                          roundingCard != null &&
                                          myFirstCars == false &&
                                          tholla == false) {
                                        setState(() {
                                          _timer.cancel();
                                          droppedCardsList.add({
                                            "suit": player2[index]["suit"],
                                            "value": player2[index]["value"],
                                            "player": "player2"
                                          });
                                          player2.removeAt(index);
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 2), () {
                                          // checkingTurn();
                                          setState(() {
                                            sideDeckShow = true;
                                            // startTimer();
                                            counter = 10;
                                          });
                                        });
                                      }
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    }
                                  }
                                      : () {},*/
                                  child: PlayingCardView(
                                    shape: ShapeBorder.lerp(
                                        Border.all(
                                            color: player3[index]["suit"] ==
                                                        roundingCard &&
                                                    turn == 3
                                                ? Colors.green
                                                : Colors.black,
                                            width: player3[index]["suit"] ==
                                                        roundingCard &&
                                                    turn == 2
                                                ? 1.5
                                                : 0.5),
                                        Border.all(),
                                        0.0),
                                    elevation: 10,
                                    card: PlayingCard(player3[index]["suit"],
                                        player3[index]["value"]),
                                    style: myCardStyles,
                                    showBack: false,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: 100,
              height: 80,
              child: PlayingCardView(
                shape: ShapeBorder.lerp(
                    Border.all(color: Colors.black), Border.all(), 0.1),
                elevation: 10,
                card: PlayingCard(Suit.joker, CardValue.joker_1),
                showBack: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(
    suitStyles: {
      Suit.spades: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♠",
            style: TextStyle(fontSize: 900),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.hearts: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♥",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.diamonds: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♦",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.clubs: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♣",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.joker: SuitStyle(builder: (context) => Container()),
    },
  );
}

///////////////////Four P_S_________///////////////////////////////////
class FourPlayer extends StatefulWidget {
  const FourPlayer({super.key});

  @override
  State<FourPlayer> createState() => _FourPlayerState();
}

class _FourPlayerState extends State<FourPlayer> {
  List droppedCardsList = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.spades, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.diamonds, "value": CardValue.five},
  ];
  List<Map> player1 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player2 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player3 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player4 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
  ];

  //////play Turn
  var roundingCard;
  bool tholla = false;
  List deck = [];
  int turn = 0;
  int counter = 10;
  late Timer _timer;
  bool sideDeckShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              "${player1.length}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        if (turn == 1)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  "$counter",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text("Player1"),
                        Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 75,
                      width: 5 + player1.length * 10,
                      decoration: turn == 1
                          ? const BoxDecoration(
                              color: Colors.red,
                              border: Border(
                                  left: BorderSide(color: Colors.red),
                                  right: BorderSide(color: Colors.red),
                                  top: BorderSide(color: Colors.red)))
                          : null,
                      child: Stack(
                        children: List.generate(player1.length, (index) {
                          return Positioned(
                            left: 7.0 * index,
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player1[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 1
                                            ? Colors.green
                                            : Colors.black,
                                        width: player1[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 1
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player1[index]["suit"],
                                    player1[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${player1.length}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            if (turn == 1)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "$counter",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Text("Player4"),
                        const Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50 + player3.length * 35,
                    width: 40,
                    child: Stack(
                      children: List.generate(player3.length, (index) {
                        return Positioned(
                          top: 10.0 * index,
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(90 / 360),
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? Colors.green
                                            : Colors.black,
                                        width: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player2[index]["suit"],
                                    player2[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50 + player3.length * 35,
                    width: 52,
                    child: Stack(
                      children: List.generate(player3.length, (index) {
                        return Positioned(
                          top: 10.0 * index,
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(90 / 360),
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? Colors.green
                                            : Colors.black,
                                        width: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player2[index]["suit"],
                                    player2[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${player1.length}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            if (turn == 1)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "$counter",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Text("Player2"),
                        const Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${player3.length}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            if (turn == 3)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "$counter",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          children: [
                            Text("Player3"),
                            Text(
                              "16581",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: turn == 3
                        ? const BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Colors.red),
                                right: BorderSide(color: Colors.red),
                                top: BorderSide(color: Colors.red)))
                        : null,
                    child: SizedBox(
                      height: 85,
                      width: 50 + player3.length * 35,
                      child: Stack(
                        children: List.generate(player3.length, (index) {
                          return Positioned(
                            left: 35.0 * index,
                            child: SizedBox(
                              width: 80,
                              height: 135,
                              child: GestureDetector(
                                // onTap: turn == 2
                                //     ? () async {
                                //   try {
                                //     bool myFirstCars = false;
                                //     if (roundingCard == null &&
                                //         myFirstCars == false) {
                                //       _timer.cancel();
                                //       setState(() {
                                //         droppedCardsList.add({
                                //           "suit": player2[index]["suit"],
                                //           "value": player2[index]["value"],
                                //           "player": "player2"
                                //         });
                                //         roundingCard = player2[index]["suit"];
                                //         myFirstCars = true;
                                //         player2.removeAt(index);
                                //       });
                                //       bool cardHai = false;
                                //       for (var element in player1) {
                                //         if (element["suit"] == roundingCard) {
                                //           setState(() {
                                //             cardHai = true;
                                //           });
                                //           break;
                                //         }
                                //       }
                                //       if (cardHai == false) {
                                //         tholla = true;
                                //       }
                                //       setState(() {
                                //         turn = 1;
                                //         // startTimer();
                                //         counter = 10;
                                //       });
                                //     }
                                //     //  ////tholla card Thrown
                                //     if (tholla == true &&
                                //         myFirstCars == false) {
                                //       setState(() {
                                //         _timer.cancel();
                                //         droppedCardsList.add({
                                //           "suit": player2[index]["suit"],
                                //           "value": player2[index]["value"],
                                //           "player": "player2"
                                //         });
                                //         player2.removeAt(index);
                                //       });
                                //       if (droppedCardsList.length == 2) {
                                //         await Future.delayed(
                                //             const Duration(seconds: 1), () {
                                //           for (var element
                                //           in droppedCardsList) {
                                //             player1.add(element);
                                //           }
                                //           setState(() {
                                //             roundingCard = null;
                                //             droppedCardsList.clear();
                                //             turn = 1;
                                //             tholla = false;
                                //             // startTimer();
                                //             counter = 10;
                                //           });
                                //         });
                                //       }
                                //     }
                                //     /////
                                //     if (roundingCard ==
                                //         player2[index]["suit"] &&
                                //         roundingCard != null &&
                                //         myFirstCars == false &&
                                //         tholla == false) {
                                //       setState(() {
                                //         _timer.cancel();
                                //         droppedCardsList.add({
                                //           "suit": player2[index]["suit"],
                                //           "value": player2[index]["value"],
                                //           "player": "player2"
                                //         });
                                //         player2.removeAt(index);
                                //       });
                                //       await Future.delayed(
                                //           const Duration(seconds: 2), () {
                                //         // checkingTurn();
                                //         setState(() {
                                //           sideDeckShow = true;
                                //           // startTimer();
                                //           counter = 10;
                                //         });
                                //       });
                                //     }
                                //   } catch (e) {
                                //     if (kDebugMode) {
                                //       print(e);
                                //     }
                                //   }
                                // }
                                //     : () {},
                                child: PlayingCardView(
                                  shape: ShapeBorder.lerp(
                                      Border.all(
                                          color: player3[index]["suit"] ==
                                                      roundingCard &&
                                                  turn == 3
                                              ? Colors.green
                                              : Colors.black,
                                          width: player3[index]["suit"] ==
                                                      roundingCard &&
                                                  turn == 2
                                              ? 1.5
                                              : 0.5),
                                      Border.all(),
                                      0.0),
                                  elevation: 10,
                                  card: PlayingCard(player3[index]["suit"],
                                      player3[index]["value"]),
                                  style: myCardStyles,
                                  showBack: false,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     RotationTransition(
              //       alignment: Alignment.bottomRight,
              //       turns: const AlwaysStoppedAnimation(90/360 ),
              //       child: Container(
              //         margin: const EdgeInsets.only(top: 140,),
              //         height: 60,
              //         width: 5 + player2.length *10,
              //         decoration: turn == 1
              //             ? const BoxDecoration(color: Colors.red,
              //             border: Border(
              //                 left: BorderSide(color: Colors.red),
              //                 right: BorderSide(color: Colors.red),
              //                 top: BorderSide(color: Colors.red)))
              //             : null,
              //         child: Stack(
              //           children: List.generate(player2.length, (index) {
              //             return Positioned(
              //               left: 7.0 * index,
              //               child: SizedBox(
              //                 width: 40,
              //                 height: 60,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(
              //                           color: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? Colors.green
              //                               : Colors.black,
              //                           width: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? 1.5
              //                               : 0.5),
              //                       Border.all(),
              //                       0.0),
              //                   elevation: 2,
              //                   card: PlayingCard(player2[index]["suit"],
              //                       player2[index]["value"]),
              //                   style: myCardStyles,
              //                   showBack: true,
              //                 ),
              //               ),
              //             );
              //           }),
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 60,),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Stack(
              //           children: [
              //             const Padding(
              //               padding: EdgeInsets.all(4.0),
              //               child: CircleAvatar(
              //                 child: Icon(Icons.person),
              //               ),
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: CircleAvatar(
              //                 radius: 10,
              //                 backgroundColor: Colors.red,
              //                 child: Text(
              //                   "${player1.length}",
              //                   style: const TextStyle(
              //                       color: Colors.white, fontSize: 10),
              //                 ),
              //               ),
              //             ),
              //             if (turn == 1)
              //               Positioned(
              //                 bottom: 0,
              //                 right: 0,
              //                 child: Container(
              //                   height: 20,
              //                   width: 20,
              //                   decoration: BoxDecoration(
              //                       color: Colors.green,
              //                       borderRadius:
              //                       BorderRadius.circular(100)),
              //                   child: Center(
              //                     child: Text(
              //                       "$counter",
              //                       style: const TextStyle(
              //                           color: Colors.white, fontSize: 10),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //           ],
              //         ),
              //         const Text("Player2"),
              //         const Text("20000",style: TextStyle(color: Colors.orange),),
              //       ],
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Stack(
              //           children: [
              //             const Padding(
              //               padding: EdgeInsets.all(4.0),
              //               child: CircleAvatar(
              //                 child: Icon(Icons.person),
              //               ),
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: CircleAvatar(
              //                 radius: 10,
              //                 backgroundColor: Colors.red,
              //                 child: Text(
              //                   "${player1.length}",
              //                   style: const TextStyle(
              //                       color: Colors.white, fontSize: 10),
              //                 ),
              //               ),
              //             ),
              //             if (turn == 1)
              //               Positioned(
              //                 bottom: 0,
              //                 right: 0,
              //                 child: Container(
              //                   height: 20,
              //                   width: 20,
              //                   decoration: BoxDecoration(
              //                       color: Colors.green,
              //                       borderRadius:
              //                       BorderRadius.circular(100)),
              //                   child: Center(
              //                     child: Text(
              //                       "$counter",
              //                       style: const TextStyle(
              //                           color: Colors.white, fontSize: 10),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //           ],
              //         ),
              //         const Text("Player4"),
              //         const Text("20000",style: TextStyle(color: Colors.orange),),
              //       ],
              //     ),
              //     const SizedBox(width: 60,),
              //     RotationTransition(
              //       alignment: Alignment.topLeft,
              //       turns: const AlwaysStoppedAnimation(90 / 360),
              //       child: Container(
              //         margin: const EdgeInsets.only(bottom: 100),
              //         height: 60,
              //         width: 5 + player2.length * 15,
              //         decoration: turn == 1
              //             ? const BoxDecoration(color: Colors.red,
              //             border: Border(
              //                 left: BorderSide(color: Colors.red),
              //                 right: BorderSide(color: Colors.red),
              //                 top: BorderSide(color: Colors.red)))
              //             : null,
              //         child: Stack(
              //           children: List.generate(player2.length, (index) {
              //             return Positioned(
              //               left: 7.0 * index,
              //               child: SizedBox(
              //                 width: 40,
              //                 height: 60,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(
              //                           color: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? Colors.green
              //                               : Colors.black,
              //                           width: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? 1.5
              //                               : 0.5),
              //                       Border.all(),
              //                       0.0),
              //                   elevation: 2,
              //                   card: PlayingCard(player2[index]["suit"],
              //                       player2[index]["value"]),
              //                   style: myCardStyles,
              //                   showBack: true,
              //                 ),
              //               ),
              //             );
              //           }),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       // height: 150,
              //       // width: 200,
              //       // margin: const EdgeInsets.only(left: 10, top: 20),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const SizedBox(
              //             height: 5,
              //           ),
              //
              //         ],
              //       ),
              //     ),
              //
              //     // Container(
              //     //   height: 150,
              //     //   width: 200,
              //     //   margin: const EdgeInsets.only(right: 10, top: 20),
              //     //   child: Column(
              //     //     crossAxisAlignment: CrossAxisAlignment.start,
              //     //     children: [
              //     //       const SizedBox(
              //     //         height: 5,
              //     //       ),
              //     //       Row(
              //     //         mainAxisAlignment: MainAxisAlignment.end,
              //     //         children: [
              //     //           const Column(
              //     //             children: [
              //     //               Text("Player2"),
              //     //               Text("1500",style: TextStyle(color: Colors.orange),),
              //     //             ],
              //     //           ),
              //     //           const SizedBox(
              //     //             width: 10,
              //     //           ),
              //     //           Stack(
              //     //             children: [
              //     //               const Padding(
              //     //                 padding: EdgeInsets.all(4.0),
              //     //                 child: CircleAvatar(
              //     //                   child: Icon(Icons.person),
              //     //                 ),
              //     //               ),
              //     //               Positioned(
              //     //                 top: 0,
              //     //                 right: 0,
              //     //                 child: CircleAvatar(
              //     //                   radius: 10,
              //     //                   backgroundColor: Colors.red,
              //     //                   child: Text(
              //     //                     "${player2.length}",
              //     //                     style: const TextStyle(
              //     //                         color: Colors.white, fontSize: 10),
              //     //                   ),
              //     //                 ),
              //     //               ),
              //     //               if (turn == 2)
              //     //                 Positioned(
              //     //                   bottom: 0,
              //     //                   right: 0,
              //     //                   child: Container(
              //     //                     height: 20,
              //     //                     width: 20,
              //     //                     decoration: BoxDecoration(
              //     //                         color: Colors.green,
              //     //                         borderRadius:
              //     //                         BorderRadius.circular(100)),
              //     //                     child: Center(
              //     //                       child: Text(
              //     //                         "$counter",
              //     //                         style: const TextStyle(
              //     //                             color: Colors.white, fontSize: 10),
              //     //                       ),
              //     //                     ),
              //     //                   ),
              //     //                 ),
              //     //             ],
              //     //           ),
              //     //         ],
              //     //       ),
              //     //       Container(
              //     //         margin: const EdgeInsets.only(left: 40),
              //     //         decoration: turn == 2
              //     //             ? const BoxDecoration(
              //     //             border: Border(
              //     //                 left: BorderSide(color: Colors.red),
              //     //                 right: BorderSide(color: Colors.red),
              //     //                 top: BorderSide(color: Colors.red)))
              //     //             : null,
              //     //         child: SizedBox(
              //     //           height: 60,
              //     //           width: 10 + player2.length * 35,
              //     //           child: Stack(
              //     //             children: List.generate(player2.length, (index) {
              //     //               return Positioned(
              //     //                 left: 7.0 * index,
              //     //                 child: SizedBox(
              //     //                   width: 40,
              //     //                   height: 60,
              //     //                   child: PlayingCardView(
              //     //                     shape: ShapeBorder.lerp(
              //     //                         Border.all(
              //     //                             color: player2[index]["suit"] ==
              //     //                                 roundingCard &&
              //     //                                 turn == 2
              //     //                                 ? Colors.green
              //     //                                 : Colors.black,
              //     //                             width: player2[index]["suit"] ==
              //     //                                 roundingCard &&
              //     //                                 turn == 2
              //     //                                 ? 1.5
              //     //                                 : 0.5),
              //     //                         Border.all(),
              //     //                         0.0),
              //     //                     elevation: 10,
              //     //                     card: PlayingCard(player2[index]["suit"],
              //     //                         player2[index]["value"]),
              //     //                     style: myCardStyles,
              //     //                     showBack: true,
              //     //                   ),
              //     //                 ),
              //     //               );
              //     //             }),
              //     //           ),
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //   ],
              // ),
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Container(
              //     margin: const EdgeInsets.only(top: 30),
              //     height: MediaQuery.of(context).size.height * 0.55,
              //     width: MediaQuery.of(context).size.width * 0.4,
              //     // color: Colors.green,
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         if (droppedCardsList.length == 1 ||
              //             droppedCardsList.length == 2 ||
              //             droppedCardsList.length == 3)
              //           Positioned(
              //             left: 2,
              //             child: RotationTransition(
              //               turns: const AlwaysStoppedAnimation(98 / 360),
              //               child: SizedBox(
              //                 height: 160,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(color: Colors.black),
              //                       Border.all(),
              //                       0.1),
              //                   elevation: 10,
              //                   card: PlayingCard(droppedCardsList[0]["suit"],
              //                       droppedCardsList[0]["value"]),
              //                   showBack: false,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         if (droppedCardsList.length == 2 ||
              //             droppedCardsList.length == 3)
              //           Positioned(
              //             top: 30,
              //             right: 20,
              //             child: RotationTransition(
              //               turns: const AlwaysStoppedAnimation(260 / 360),
              //               child: SizedBox(
              //                 height: 160,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(color: Colors.black),
              //                       Border.all(),
              //                       0.1),
              //                   card: PlayingCard(droppedCardsList[1]["suit"],
              //                       droppedCardsList[1]["value"]),
              //                   showBack: false,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         if (droppedCardsList.length == 3)
              //           Positioned(
              //             top: 0,
              //             child: SizedBox(
              //               height: 160,
              //               child: PlayingCardView(
              //                 shape: ShapeBorder.lerp(
              //                     Border.all(color: Colors.black),
              //                     Border.all(),
              //                     0.1),
              //                 card: PlayingCard(droppedCardsList[2]["suit"],
              //                     droppedCardsList[2]["value"]),
              //                 showBack: false,
              //               ),
              //             ),
              //           ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   bottom: 0,
              //   child: SizedBox(
              //     width: Get.width,
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left: 80),
              //           child: Row(
              //             children: [
              //               Stack(
              //                 children: [
              //                   const Padding(
              //                     padding: EdgeInsets.all(4.0),
              //                     child: CircleAvatar(
              //                       child: Icon(Icons.person),
              //                     ),
              //                   ),
              //                   Positioned(
              //                     top: 0,
              //                     right: 0,
              //                     child: CircleAvatar(
              //                       radius: 10,
              //                       backgroundColor: Colors.red,
              //                       child: Text(
              //                         "${player3.length}",
              //                         style: const TextStyle(
              //                             color: Colors.white, fontSize: 10),
              //                       ),
              //                     ),
              //                   ),
              //                   if (turn == 3)
              //                     Positioned(
              //                       bottom: 0,
              //                       right: 0,
              //                       child: Container(
              //                         height: 20,
              //                         width: 20,
              //                         decoration: BoxDecoration(
              //                             color: Colors.green,
              //                             borderRadius:
              //                             BorderRadius.circular(100)),
              //                         child: Center(
              //                           child: Text(
              //                             "$counter",
              //                             style: const TextStyle(
              //                                 color: Colors.white, fontSize: 10),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               const Column(
              //                 children: [
              //                   Text("Player3"),
              //                   Text("16581",style: TextStyle(color: Colors.orange),),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //         Container(
              //           decoration: turn == 3
              //               ? const BoxDecoration(
              //               border: Border(
              //                   left: BorderSide(color: Colors.red),
              //                   right: BorderSide(color: Colors.red),
              //                   top: BorderSide(color: Colors.red)))
              //               : null,
              //           child: SizedBox(
              //             height: 85,
              //             width: 50 + player3.length * 35,
              //             child: Stack(
              //               children: List.generate(player3.length, (index) {
              //                 return Positioned(
              //                   left: 35.0 * index,
              //                   child: SizedBox(
              //                     width: 80,
              //                     height: 135,
              //                     child: GestureDetector(
              //                       // onTap: turn == 2
              //                       //     ? () async {
              //                       //   try {
              //                       //     bool myFirstCars = false;
              //                       //     if (roundingCard == null &&
              //                       //         myFirstCars == false) {
              //                       //       _timer.cancel();
              //                       //       setState(() {
              //                       //         droppedCardsList.add({
              //                       //           "suit": player2[index]["suit"],
              //                       //           "value": player2[index]["value"],
              //                       //           "player": "player2"
              //                       //         });
              //                       //         roundingCard = player2[index]["suit"];
              //                       //         myFirstCars = true;
              //                       //         player2.removeAt(index);
              //                       //       });
              //                       //       bool cardHai = false;
              //                       //       for (var element in player1) {
              //                       //         if (element["suit"] == roundingCard) {
              //                       //           setState(() {
              //                       //             cardHai = true;
              //                       //           });
              //                       //           break;
              //                       //         }
              //                       //       }
              //                       //       if (cardHai == false) {
              //                       //         tholla = true;
              //                       //       }
              //                       //       setState(() {
              //                       //         turn = 1;
              //                       //         // startTimer();
              //                       //         counter = 10;
              //                       //       });
              //                       //     }
              //                       //     //  ////tholla card Thrown
              //                       //     if (tholla == true &&
              //                       //         myFirstCars == false) {
              //                       //       setState(() {
              //                       //         _timer.cancel();
              //                       //         droppedCardsList.add({
              //                       //           "suit": player2[index]["suit"],
              //                       //           "value": player2[index]["value"],
              //                       //           "player": "player2"
              //                       //         });
              //                       //         player2.removeAt(index);
              //                       //       });
              //                       //       if (droppedCardsList.length == 2) {
              //                       //         await Future.delayed(
              //                       //             const Duration(seconds: 1), () {
              //                       //           for (var element
              //                       //           in droppedCardsList) {
              //                       //             player1.add(element);
              //                       //           }
              //                       //           setState(() {
              //                       //             roundingCard = null;
              //                       //             droppedCardsList.clear();
              //                       //             turn = 1;
              //                       //             tholla = false;
              //                       //             // startTimer();
              //                       //             counter = 10;
              //                       //           });
              //                       //         });
              //                       //       }
              //                       //     }
              //                       //     /////
              //                       //     if (roundingCard ==
              //                       //         player2[index]["suit"] &&
              //                       //         roundingCard != null &&
              //                       //         myFirstCars == false &&
              //                       //         tholla == false) {
              //                       //       setState(() {
              //                       //         _timer.cancel();
              //                       //         droppedCardsList.add({
              //                       //           "suit": player2[index]["suit"],
              //                       //           "value": player2[index]["value"],
              //                       //           "player": "player2"
              //                       //         });
              //                       //         player2.removeAt(index);
              //                       //       });
              //                       //       await Future.delayed(
              //                       //           const Duration(seconds: 2), () {
              //                       //         // checkingTurn();
              //                       //         setState(() {
              //                       //           sideDeckShow = true;
              //                       //           // startTimer();
              //                       //           counter = 10;
              //                       //         });
              //                       //       });
              //                       //     }
              //                       //   } catch (e) {
              //                       //     if (kDebugMode) {
              //                       //       print(e);
              //                       //     }
              //                       //   }
              //                       // }
              //                       //     : () {},
              //                       child: PlayingCardView(
              //                         shape: ShapeBorder.lerp(
              //                             Border.all(
              //                                 color: player3[index]["suit"] ==
              //                                     roundingCard &&
              //                                     turn == 3
              //                                     ? Colors.green
              //                                     : Colors.black,
              //                                 width: player3[index]["suit"] ==
              //                                     roundingCard &&
              //                                     turn == 2
              //                                     ? 1.5
              //                                     : 0.5),
              //                             Border.all(),
              //                             0.0),
              //                         elevation: 10,
              //                         card: PlayingCard(player3[index]["suit"],
              //                             player3[index]["value"]),
              //                         style: myCardStyles,
              //                         showBack: false,
              //                       ),
              //                     ),
              //                   ),
              //                 );
              //               }),
              //             ),
              //           ),
              //         ),
              //
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   right: 30,
              //   bottom: 100,
              //   height: 80,
              //   child: PlayingCardView(
              //     shape: ShapeBorder.lerp(
              //         Border.all(color: Colors.black), Border.all(), 0.1),
              //     elevation: 10,
              //     card: PlayingCard(Suit.joker, CardValue.joker_1),
              //     showBack: true,
              //   ),
              // ),
            ],
          ),
          Center(
            child: SizedBox(
              // margin: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.45,
              // color: Colors.green,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (droppedCardsList.length == 1 ||
                      droppedCardsList.length == 2 ||
                      droppedCardsList.length == 3 ||
                      droppedCardsList.length == 4)
                    Positioned(
                      left: 20,
                      top: 30,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(95 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            elevation: 10,
                            card: PlayingCard(droppedCardsList[0]["suit"],
                                droppedCardsList[0]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 2 ||
                      droppedCardsList.length == 3 ||
                      droppedCardsList.length == 4)
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        height: 120,
                        child: PlayingCardView(
                          shape: ShapeBorder.lerp(
                              Border.all(color: Colors.black),
                              Border.all(),
                              0.1),
                          card: PlayingCard(droppedCardsList[1]["suit"],
                              droppedCardsList[1]["value"]),
                          showBack: false,
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 3 ||
                      droppedCardsList.length == 4)
                    Positioned(
                      top: 10,
                      right: 25,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(260 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[2]["suit"],
                                droppedCardsList[2]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 4)
                    Positioned(
                      bottom: 35,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(170 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[3]["suit"],
                                droppedCardsList[3]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(
    suitStyles: {
      Suit.spades: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♠",
            style: TextStyle(fontSize: 900),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.hearts: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♥",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.diamonds: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♦",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.clubs: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♣",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.joker: SuitStyle(builder: (context) => Container()),
    },
  );
}

///////////////////FIVE P_S_________///////////////////////////////////

class FivePlayer extends StatefulWidget {
  const FivePlayer({super.key});

  @override
  State<FivePlayer> createState() => _FivePlayerState();
}

class _FivePlayerState extends State<FivePlayer> {
  List droppedCardsList = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.spades, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.diamonds, "value": CardValue.five},
    {"suit": Suit.spades, "value": CardValue.nine},
  ];
  List<Map> player1 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player2 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
    {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player3 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player4 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
  ];
  List<Map> player5 = [
    {"suit": Suit.hearts, "value": CardValue.ace},
    {"suit": Suit.diamonds, "value": CardValue.three},
    {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
    // {"suit": Suit.hearts, "value": CardValue.five},
  ];

  //////play Turn
  var roundingCard;
  bool tholla = false;
  List deck = [];
  int turn = 0;
  int counter = 10;
  late Timer _timer;
  bool sideDeckShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 60,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              "${player1.length}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        if (turn == 1)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  "$counter",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text("Player1"),
                        Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 75,
                      width: 5 + player1.length * 10,
                      decoration: turn == 1
                          ? const BoxDecoration(
                              color: Colors.red,
                              border: Border(
                                  left: BorderSide(color: Colors.red),
                                  right: BorderSide(color: Colors.red),
                                  top: BorderSide(color: Colors.red)))
                          : null,
                      child: Stack(
                        children: List.generate(player1.length, (index) {
                          return Positioned(
                            left: 7.0 * index,
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player1[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 1
                                            ? Colors.green
                                            : Colors.black,
                                        width: player1[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 1
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player1[index]["suit"],
                                    player1[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 75,
                      width: 5 + player1.length * 10,
                      decoration: turn == 1
                          ? const BoxDecoration(
                          color: Colors.red,
                          border: Border(
                              left: BorderSide(color: Colors.red),
                              right: BorderSide(color: Colors.red),
                              top: BorderSide(color: Colors.red)))
                          : null,
                      child: Stack(
                        children: List.generate(player1.length, (index) {
                          return Positioned(
                            left: 7.0 * index,
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player1[index]["suit"] ==
                                            roundingCard &&
                                            turn == 1
                                            ? Colors.green
                                            : Colors.black,
                                        width: player1[index]["suit"] ==
                                            roundingCard &&
                                            turn == 1
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player1[index]["suit"],
                                    player1[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              "${player1.length}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        if (turn == 1)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Text(
                                  "$counter",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text("Player1"),
                        Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${player1.length}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            if (turn == 1)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "$counter",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Text("Player4"),
                        const Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50 + player3.length * 35,
                    width: 40,
                    child: Stack(
                      children: List.generate(player3.length, (index) {
                        return Positioned(
                          top: 10.0 * index,
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(90 / 360),
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? Colors.green
                                            : Colors.black,
                                        width: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player2[index]["suit"],
                                    player2[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50 + player3.length * 35,
                    width: 52,
                    child: Stack(
                      children: List.generate(player3.length, (index) {
                        return Positioned(
                          top: 10.0 * index,
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(90 / 360),
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: PlayingCardView(
                                shape: ShapeBorder.lerp(
                                    Border.all(
                                        color: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? Colors.green
                                            : Colors.black,
                                        width: player2[index]["suit"] ==
                                                    roundingCard &&
                                                turn == 2
                                            ? 1.5
                                            : 0.5),
                                    Border.all(),
                                    0.0),
                                elevation: 10,
                                card: PlayingCard(player2[index]["suit"],
                                    player2[index]["value"]),
                                style: myCardStyles,
                                showBack: true,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${player1.length}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            if (turn == 1)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "$counter",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Text("Player2"),
                        const Text(
                          "20000",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  "${player3.length}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            if (turn == 3)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      "$counter",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          children: [
                            Text("Player3"),
                            Text(
                              "16581",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: turn == 3
                        ? const BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Colors.red),
                                right: BorderSide(color: Colors.red),
                                top: BorderSide(color: Colors.red)))
                        : null,
                    child: SizedBox(
                      height: 85,
                      width: 50 + player3.length * 35,
                      child: Stack(
                        children: List.generate(player3.length, (index) {
                          return Positioned(
                            left: 35.0 * index,
                            child: SizedBox(
                              width: 80,
                              height: 135,
                              child: GestureDetector(
                                // onTap: turn == 2
                                //     ? () async {
                                //   try {
                                //     bool myFirstCars = false;
                                //     if (roundingCard == null &&
                                //         myFirstCars == false) {
                                //       _timer.cancel();
                                //       setState(() {
                                //         droppedCardsList.add({
                                //           "suit": player2[index]["suit"],
                                //           "value": player2[index]["value"],
                                //           "player": "player2"
                                //         });
                                //         roundingCard = player2[index]["suit"];
                                //         myFirstCars = true;
                                //         player2.removeAt(index);
                                //       });
                                //       bool cardHai = false;
                                //       for (var element in player1) {
                                //         if (element["suit"] == roundingCard) {
                                //           setState(() {
                                //             cardHai = true;
                                //           });
                                //           break;
                                //         }
                                //       }
                                //       if (cardHai == false) {
                                //         tholla = true;
                                //       }
                                //       setState(() {
                                //         turn = 1;
                                //         // startTimer();
                                //         counter = 10;
                                //       });
                                //     }
                                //     //  ////tholla card Thrown
                                //     if (tholla == true &&
                                //         myFirstCars == false) {
                                //       setState(() {
                                //         _timer.cancel();
                                //         droppedCardsList.add({
                                //           "suit": player2[index]["suit"],
                                //           "value": player2[index]["value"],
                                //           "player": "player2"
                                //         });
                                //         player2.removeAt(index);
                                //       });
                                //       if (droppedCardsList.length == 2) {
                                //         await Future.delayed(
                                //             const Duration(seconds: 1), () {
                                //           for (var element
                                //           in droppedCardsList) {
                                //             player1.add(element);
                                //           }
                                //           setState(() {
                                //             roundingCard = null;
                                //             droppedCardsList.clear();
                                //             turn = 1;
                                //             tholla = false;
                                //             // startTimer();
                                //             counter = 10;
                                //           });
                                //         });
                                //       }
                                //     }
                                //     /////
                                //     if (roundingCard ==
                                //         player2[index]["suit"] &&
                                //         roundingCard != null &&
                                //         myFirstCars == false &&
                                //         tholla == false) {
                                //       setState(() {
                                //         _timer.cancel();
                                //         droppedCardsList.add({
                                //           "suit": player2[index]["suit"],
                                //           "value": player2[index]["value"],
                                //           "player": "player2"
                                //         });
                                //         player2.removeAt(index);
                                //       });
                                //       await Future.delayed(
                                //           const Duration(seconds: 2), () {
                                //         // checkingTurn();
                                //         setState(() {
                                //           sideDeckShow = true;
                                //           // startTimer();
                                //           counter = 10;
                                //         });
                                //       });
                                //     }
                                //   } catch (e) {
                                //     if (kDebugMode) {
                                //       print(e);
                                //     }
                                //   }
                                // }
                                //     : () {},
                                child: PlayingCardView(
                                  shape: ShapeBorder.lerp(
                                      Border.all(
                                          color: player3[index]["suit"] ==
                                                      roundingCard &&
                                                  turn == 3
                                              ? Colors.green
                                              : Colors.black,
                                          width: player3[index]["suit"] ==
                                                      roundingCard &&
                                                  turn == 2
                                              ? 1.5
                                              : 0.5),
                                      Border.all(),
                                      0.0),
                                  elevation: 10,
                                  card: PlayingCard(player3[index]["suit"],
                                      player3[index]["value"]),
                                  style: myCardStyles,
                                  showBack: false,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     RotationTransition(
              //       alignment: Alignment.bottomRight,
              //       turns: const AlwaysStoppedAnimation(90/360 ),
              //       child: Container(
              //         margin: const EdgeInsets.only(top: 140,),
              //         height: 60,
              //         width: 5 + player2.length *10,
              //         decoration: turn == 1
              //             ? const BoxDecoration(color: Colors.red,
              //             border: Border(
              //                 left: BorderSide(color: Colors.red),
              //                 right: BorderSide(color: Colors.red),
              //                 top: BorderSide(color: Colors.red)))
              //             : null,
              //         child: Stack(
              //           children: List.generate(player2.length, (index) {
              //             return Positioned(
              //               left: 7.0 * index,
              //               child: SizedBox(
              //                 width: 40,
              //                 height: 60,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(
              //                           color: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? Colors.green
              //                               : Colors.black,
              //                           width: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? 1.5
              //                               : 0.5),
              //                       Border.all(),
              //                       0.0),
              //                   elevation: 2,
              //                   card: PlayingCard(player2[index]["suit"],
              //                       player2[index]["value"]),
              //                   style: myCardStyles,
              //                   showBack: true,
              //                 ),
              //               ),
              //             );
              //           }),
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 60,),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Stack(
              //           children: [
              //             const Padding(
              //               padding: EdgeInsets.all(4.0),
              //               child: CircleAvatar(
              //                 child: Icon(Icons.person),
              //               ),
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: CircleAvatar(
              //                 radius: 10,
              //                 backgroundColor: Colors.red,
              //                 child: Text(
              //                   "${player1.length}",
              //                   style: const TextStyle(
              //                       color: Colors.white, fontSize: 10),
              //                 ),
              //               ),
              //             ),
              //             if (turn == 1)
              //               Positioned(
              //                 bottom: 0,
              //                 right: 0,
              //                 child: Container(
              //                   height: 20,
              //                   width: 20,
              //                   decoration: BoxDecoration(
              //                       color: Colors.green,
              //                       borderRadius:
              //                       BorderRadius.circular(100)),
              //                   child: Center(
              //                     child: Text(
              //                       "$counter",
              //                       style: const TextStyle(
              //                           color: Colors.white, fontSize: 10),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //           ],
              //         ),
              //         const Text("Player2"),
              //         const Text("20000",style: TextStyle(color: Colors.orange),),
              //       ],
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Stack(
              //           children: [
              //             const Padding(
              //               padding: EdgeInsets.all(4.0),
              //               child: CircleAvatar(
              //                 child: Icon(Icons.person),
              //               ),
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: CircleAvatar(
              //                 radius: 10,
              //                 backgroundColor: Colors.red,
              //                 child: Text(
              //                   "${player1.length}",
              //                   style: const TextStyle(
              //                       color: Colors.white, fontSize: 10),
              //                 ),
              //               ),
              //             ),
              //             if (turn == 1)
              //               Positioned(
              //                 bottom: 0,
              //                 right: 0,
              //                 child: Container(
              //                   height: 20,
              //                   width: 20,
              //                   decoration: BoxDecoration(
              //                       color: Colors.green,
              //                       borderRadius:
              //                       BorderRadius.circular(100)),
              //                   child: Center(
              //                     child: Text(
              //                       "$counter",
              //                       style: const TextStyle(
              //                           color: Colors.white, fontSize: 10),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //           ],
              //         ),
              //         const Text("Player4"),
              //         const Text("20000",style: TextStyle(color: Colors.orange),),
              //       ],
              //     ),
              //     const SizedBox(width: 60,),
              //     RotationTransition(
              //       alignment: Alignment.topLeft,
              //       turns: const AlwaysStoppedAnimation(90 / 360),
              //       child: Container(
              //         margin: const EdgeInsets.only(bottom: 100),
              //         height: 60,
              //         width: 5 + player2.length * 15,
              //         decoration: turn == 1
              //             ? const BoxDecoration(color: Colors.red,
              //             border: Border(
              //                 left: BorderSide(color: Colors.red),
              //                 right: BorderSide(color: Colors.red),
              //                 top: BorderSide(color: Colors.red)))
              //             : null,
              //         child: Stack(
              //           children: List.generate(player2.length, (index) {
              //             return Positioned(
              //               left: 7.0 * index,
              //               child: SizedBox(
              //                 width: 40,
              //                 height: 60,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(
              //                           color: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? Colors.green
              //                               : Colors.black,
              //                           width: player2[index]["suit"] ==
              //                               roundingCard &&
              //                               turn == 1
              //                               ? 1.5
              //                               : 0.5),
              //                       Border.all(),
              //                       0.0),
              //                   elevation: 2,
              //                   card: PlayingCard(player2[index]["suit"],
              //                       player2[index]["value"]),
              //                   style: myCardStyles,
              //                   showBack: true,
              //                 ),
              //               ),
              //             );
              //           }),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       // height: 150,
              //       // width: 200,
              //       // margin: const EdgeInsets.only(left: 10, top: 20),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const SizedBox(
              //             height: 5,
              //           ),
              //
              //         ],
              //       ),
              //     ),
              //
              //     // Container(
              //     //   height: 150,
              //     //   width: 200,
              //     //   margin: const EdgeInsets.only(right: 10, top: 20),
              //     //   child: Column(
              //     //     crossAxisAlignment: CrossAxisAlignment.start,
              //     //     children: [
              //     //       const SizedBox(
              //     //         height: 5,
              //     //       ),
              //     //       Row(
              //     //         mainAxisAlignment: MainAxisAlignment.end,
              //     //         children: [
              //     //           const Column(
              //     //             children: [
              //     //               Text("Player2"),
              //     //               Text("1500",style: TextStyle(color: Colors.orange),),
              //     //             ],
              //     //           ),
              //     //           const SizedBox(
              //     //             width: 10,
              //     //           ),
              //     //           Stack(
              //     //             children: [
              //     //               const Padding(
              //     //                 padding: EdgeInsets.all(4.0),
              //     //                 child: CircleAvatar(
              //     //                   child: Icon(Icons.person),
              //     //                 ),
              //     //               ),
              //     //               Positioned(
              //     //                 top: 0,
              //     //                 right: 0,
              //     //                 child: CircleAvatar(
              //     //                   radius: 10,
              //     //                   backgroundColor: Colors.red,
              //     //                   child: Text(
              //     //                     "${player2.length}",
              //     //                     style: const TextStyle(
              //     //                         color: Colors.white, fontSize: 10),
              //     //                   ),
              //     //                 ),
              //     //               ),
              //     //               if (turn == 2)
              //     //                 Positioned(
              //     //                   bottom: 0,
              //     //                   right: 0,
              //     //                   child: Container(
              //     //                     height: 20,
              //     //                     width: 20,
              //     //                     decoration: BoxDecoration(
              //     //                         color: Colors.green,
              //     //                         borderRadius:
              //     //                         BorderRadius.circular(100)),
              //     //                     child: Center(
              //     //                       child: Text(
              //     //                         "$counter",
              //     //                         style: const TextStyle(
              //     //                             color: Colors.white, fontSize: 10),
              //     //                       ),
              //     //                     ),
              //     //                   ),
              //     //                 ),
              //     //             ],
              //     //           ),
              //     //         ],
              //     //       ),
              //     //       Container(
              //     //         margin: const EdgeInsets.only(left: 40),
              //     //         decoration: turn == 2
              //     //             ? const BoxDecoration(
              //     //             border: Border(
              //     //                 left: BorderSide(color: Colors.red),
              //     //                 right: BorderSide(color: Colors.red),
              //     //                 top: BorderSide(color: Colors.red)))
              //     //             : null,
              //     //         child: SizedBox(
              //     //           height: 60,
              //     //           width: 10 + player2.length * 35,
              //     //           child: Stack(
              //     //             children: List.generate(player2.length, (index) {
              //     //               return Positioned(
              //     //                 left: 7.0 * index,
              //     //                 child: SizedBox(
              //     //                   width: 40,
              //     //                   height: 60,
              //     //                   child: PlayingCardView(
              //     //                     shape: ShapeBorder.lerp(
              //     //                         Border.all(
              //     //                             color: player2[index]["suit"] ==
              //     //                                 roundingCard &&
              //     //                                 turn == 2
              //     //                                 ? Colors.green
              //     //                                 : Colors.black,
              //     //                             width: player2[index]["suit"] ==
              //     //                                 roundingCard &&
              //     //                                 turn == 2
              //     //                                 ? 1.5
              //     //                                 : 0.5),
              //     //                         Border.all(),
              //     //                         0.0),
              //     //                     elevation: 10,
              //     //                     card: PlayingCard(player2[index]["suit"],
              //     //                         player2[index]["value"]),
              //     //                     style: myCardStyles,
              //     //                     showBack: true,
              //     //                   ),
              //     //                 ),
              //     //               );
              //     //             }),
              //     //           ),
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //   ],
              // ),
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Container(
              //     margin: const EdgeInsets.only(top: 30),
              //     height: MediaQuery.of(context).size.height * 0.55,
              //     width: MediaQuery.of(context).size.width * 0.4,
              //     // color: Colors.green,
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         if (droppedCardsList.length == 1 ||
              //             droppedCardsList.length == 2 ||
              //             droppedCardsList.length == 3)
              //           Positioned(
              //             left: 2,
              //             child: RotationTransition(
              //               turns: const AlwaysStoppedAnimation(98 / 360),
              //               child: SizedBox(
              //                 height: 160,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(color: Colors.black),
              //                       Border.all(),
              //                       0.1),
              //                   elevation: 10,
              //                   card: PlayingCard(droppedCardsList[0]["suit"],
              //                       droppedCardsList[0]["value"]),
              //                   showBack: false,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         if (droppedCardsList.length == 2 ||
              //             droppedCardsList.length == 3)
              //           Positioned(
              //             top: 30,
              //             right: 20,
              //             child: RotationTransition(
              //               turns: const AlwaysStoppedAnimation(260 / 360),
              //               child: SizedBox(
              //                 height: 160,
              //                 child: PlayingCardView(
              //                   shape: ShapeBorder.lerp(
              //                       Border.all(color: Colors.black),
              //                       Border.all(),
              //                       0.1),
              //                   card: PlayingCard(droppedCardsList[1]["suit"],
              //                       droppedCardsList[1]["value"]),
              //                   showBack: false,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         if (droppedCardsList.length == 3)
              //           Positioned(
              //             top: 0,
              //             child: SizedBox(
              //               height: 160,
              //               child: PlayingCardView(
              //                 shape: ShapeBorder.lerp(
              //                     Border.all(color: Colors.black),
              //                     Border.all(),
              //                     0.1),
              //                 card: PlayingCard(droppedCardsList[2]["suit"],
              //                     droppedCardsList[2]["value"]),
              //                 showBack: false,
              //               ),
              //             ),
              //           ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   bottom: 0,
              //   child: SizedBox(
              //     width: Get.width,
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left: 80),
              //           child: Row(
              //             children: [
              //               Stack(
              //                 children: [
              //                   const Padding(
              //                     padding: EdgeInsets.all(4.0),
              //                     child: CircleAvatar(
              //                       child: Icon(Icons.person),
              //                     ),
              //                   ),
              //                   Positioned(
              //                     top: 0,
              //                     right: 0,
              //                     child: CircleAvatar(
              //                       radius: 10,
              //                       backgroundColor: Colors.red,
              //                       child: Text(
              //                         "${player3.length}",
              //                         style: const TextStyle(
              //                             color: Colors.white, fontSize: 10),
              //                       ),
              //                     ),
              //                   ),
              //                   if (turn == 3)
              //                     Positioned(
              //                       bottom: 0,
              //                       right: 0,
              //                       child: Container(
              //                         height: 20,
              //                         width: 20,
              //                         decoration: BoxDecoration(
              //                             color: Colors.green,
              //                             borderRadius:
              //                             BorderRadius.circular(100)),
              //                         child: Center(
              //                           child: Text(
              //                             "$counter",
              //                             style: const TextStyle(
              //                                 color: Colors.white, fontSize: 10),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               const Column(
              //                 children: [
              //                   Text("Player3"),
              //                   Text("16581",style: TextStyle(color: Colors.orange),),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //         Container(
              //           decoration: turn == 3
              //               ? const BoxDecoration(
              //               border: Border(
              //                   left: BorderSide(color: Colors.red),
              //                   right: BorderSide(color: Colors.red),
              //                   top: BorderSide(color: Colors.red)))
              //               : null,
              //           child: SizedBox(
              //             height: 85,
              //             width: 50 + player3.length * 35,
              //             child: Stack(
              //               children: List.generate(player3.length, (index) {
              //                 return Positioned(
              //                   left: 35.0 * index,
              //                   child: SizedBox(
              //                     width: 80,
              //                     height: 135,
              //                     child: GestureDetector(
              //                       // onTap: turn == 2
              //                       //     ? () async {
              //                       //   try {
              //                       //     bool myFirstCars = false;
              //                       //     if (roundingCard == null &&
              //                       //         myFirstCars == false) {
              //                       //       _timer.cancel();
              //                       //       setState(() {
              //                       //         droppedCardsList.add({
              //                       //           "suit": player2[index]["suit"],
              //                       //           "value": player2[index]["value"],
              //                       //           "player": "player2"
              //                       //         });
              //                       //         roundingCard = player2[index]["suit"];
              //                       //         myFirstCars = true;
              //                       //         player2.removeAt(index);
              //                       //       });
              //                       //       bool cardHai = false;
              //                       //       for (var element in player1) {
              //                       //         if (element["suit"] == roundingCard) {
              //                       //           setState(() {
              //                       //             cardHai = true;
              //                       //           });
              //                       //           break;
              //                       //         }
              //                       //       }
              //                       //       if (cardHai == false) {
              //                       //         tholla = true;
              //                       //       }
              //                       //       setState(() {
              //                       //         turn = 1;
              //                       //         // startTimer();
              //                       //         counter = 10;
              //                       //       });
              //                       //     }
              //                       //     //  ////tholla card Thrown
              //                       //     if (tholla == true &&
              //                       //         myFirstCars == false) {
              //                       //       setState(() {
              //                       //         _timer.cancel();
              //                       //         droppedCardsList.add({
              //                       //           "suit": player2[index]["suit"],
              //                       //           "value": player2[index]["value"],
              //                       //           "player": "player2"
              //                       //         });
              //                       //         player2.removeAt(index);
              //                       //       });
              //                       //       if (droppedCardsList.length == 2) {
              //                       //         await Future.delayed(
              //                       //             const Duration(seconds: 1), () {
              //                       //           for (var element
              //                       //           in droppedCardsList) {
              //                       //             player1.add(element);
              //                       //           }
              //                       //           setState(() {
              //                       //             roundingCard = null;
              //                       //             droppedCardsList.clear();
              //                       //             turn = 1;
              //                       //             tholla = false;
              //                       //             // startTimer();
              //                       //             counter = 10;
              //                       //           });
              //                       //         });
              //                       //       }
              //                       //     }
              //                       //     /////
              //                       //     if (roundingCard ==
              //                       //         player2[index]["suit"] &&
              //                       //         roundingCard != null &&
              //                       //         myFirstCars == false &&
              //                       //         tholla == false) {
              //                       //       setState(() {
              //                       //         _timer.cancel();
              //                       //         droppedCardsList.add({
              //                       //           "suit": player2[index]["suit"],
              //                       //           "value": player2[index]["value"],
              //                       //           "player": "player2"
              //                       //         });
              //                       //         player2.removeAt(index);
              //                       //       });
              //                       //       await Future.delayed(
              //                       //           const Duration(seconds: 2), () {
              //                       //         // checkingTurn();
              //                       //         setState(() {
              //                       //           sideDeckShow = true;
              //                       //           // startTimer();
              //                       //           counter = 10;
              //                       //         });
              //                       //       });
              //                       //     }
              //                       //   } catch (e) {
              //                       //     if (kDebugMode) {
              //                       //       print(e);
              //                       //     }
              //                       //   }
              //                       // }
              //                       //     : () {},
              //                       child: PlayingCardView(
              //                         shape: ShapeBorder.lerp(
              //                             Border.all(
              //                                 color: player3[index]["suit"] ==
              //                                     roundingCard &&
              //                                     turn == 3
              //                                     ? Colors.green
              //                                     : Colors.black,
              //                                 width: player3[index]["suit"] ==
              //                                     roundingCard &&
              //                                     turn == 2
              //                                     ? 1.5
              //                                     : 0.5),
              //                             Border.all(),
              //                             0.0),
              //                         elevation: 10,
              //                         card: PlayingCard(player3[index]["suit"],
              //                             player3[index]["value"]),
              //                         style: myCardStyles,
              //                         showBack: false,
              //                       ),
              //                     ),
              //                   ),
              //                 );
              //               }),
              //             ),
              //           ),
              //         ),
              //
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   right: 30,
              //   bottom: 100,
              //   height: 80,
              //   child: PlayingCardView(
              //     shape: ShapeBorder.lerp(
              //         Border.all(color: Colors.black), Border.all(), 0.1),
              //     elevation: 10,
              //     card: PlayingCard(Suit.joker, CardValue.joker_1),
              //     showBack: true,
              //   ),
              // ),
            ],
          ),
          Center(
            child: SizedBox(
              // margin: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.45,
              // color: Colors.green,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (droppedCardsList.length == 1 ||
                      droppedCardsList.length == 2 ||
                      droppedCardsList.length == 3 ||
                      droppedCardsList.length == 4||
                      droppedCardsList.length == 5)
                    Positioned(
                      left: 0,
                      top: 40,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(95 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            elevation: 10,
                            card: PlayingCard(droppedCardsList[0]["suit"],
                                droppedCardsList[0]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 2 ||
                      droppedCardsList.length == 3 ||
                      droppedCardsList.length == 4||
                      droppedCardsList.length == 5)
                    Positioned(
                      top: 0,
                      left: 60,
                      child: SizedBox(
                        height: 120,
                        child: PlayingCardView(
                          shape: ShapeBorder.lerp(
                              Border.all(color: Colors.black),
                              Border.all(),
                              0.1),
                          card: PlayingCard(droppedCardsList[1]["suit"],
                              droppedCardsList[1]["value"]),
                          showBack: false,
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 3 ||
                      droppedCardsList.length == 4||
                      droppedCardsList.length == 5)
                    Positioned(
                      top: 20,
                      right: 60,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(240 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[2]["suit"],
                                droppedCardsList[2]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 4||
                      droppedCardsList.length == 5)
                    Positioned(
                      bottom: 25,
                      left: 120,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(170 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[3]["suit"],
                                droppedCardsList[3]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                  if (droppedCardsList.length == 5)
                    Positioned(
                      bottom: 40,
                      left: 50,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(150 / 360),
                        child: SizedBox(
                          height: 120,
                          child: PlayingCardView(
                            shape: ShapeBorder.lerp(
                                Border.all(color: Colors.black),
                                Border.all(),
                                0.1),
                            card: PlayingCard(droppedCardsList[4]["suit"],
                                droppedCardsList[4]["value"]),
                            showBack: false,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(
    suitStyles: {
      Suit.spades: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♠",
            style: TextStyle(fontSize: 900),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.hearts: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♥",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.diamonds: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♦",
            style: TextStyle(fontSize: 500, color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.red),
      ),
      Suit.clubs: SuitStyle(
        builder: (context) => const FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♣",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800]),
      ),
      Suit.joker: SuitStyle(builder: (context) => Container()),
    },
  );
}
