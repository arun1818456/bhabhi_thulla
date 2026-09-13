import 'dart:math';
import 'dart:ui';
import '../../constant/export_file.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.data});

  final Map data;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final List<AnimatingCardModel> _animatingCards = [];
  GameController controller = Get.put(GameController());

  @override
  void initState() {
    super.initState();
    debugPrint("GameScreen data: ${widget.data}");
    controller.mySeat = widget.data["yourSeat"] ?? widget.data["seat"];
    controller.playersCount = widget.data["playersCount"];
    controller.roomId = widget.data["roomId"];
    controller.players =
        widget.data["players"] != null && widget.data["players"] is List
        ? List.from(widget.data["players"])
        : [];
    controller.entryFee = widget.data["entryFee"];
    controller.currentTurn = widget.data["currentTurn"];
    controller.currentSuitChal = "spades";
    controller.firstChal = true;

    final dynamic rawHandCards =
        widget.data["myCards"] ?? widget.data["handCards"];
    if (rawHandCards != null && rawHandCards is List) {
      controller.handCards = (rawHandCards)
          .map(
            (e) => e is Map
                ? Map<String, dynamic>.from(e)
                : e is List
                ? {"rank": parseRank(e[0]), "suit": e[1]}
                : <String, dynamic>{},
          )
          .toList();
      controller.sortHandCards();
    } else {
      controller.handCards = [];
    }
    controller.tableCards = [];

    controller.onCardPlayedReceived = (data) {
      _handleCardPlayedSocket(data);
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        controller.update();
      }
    });
  }

  @override
  void dispose() {
    for (final animCard in _animatingCards) {
      animCard.controller.dispose();
    }
    super.dispose();
  }

  static const List<Alignment> playerAlignments = [
    Alignment(-0.88, 0.7), // Position 0: Bottom (Current User / Me)
    Alignment(0.88, -0.15), // Position 1: Right
    Alignment(0, -0.9), // Position 2: Top (Samne)
    Alignment(-0.88, -0.15), // Position 3: Left
  ];

  List<Widget> _buildPlayerProfiles(GameController controller) {
    final String myUserId = controller.getUserData().id ?? "";

    // 1. Determine my seat number (1..4)
    int mySeat = controller.mySeat ?? widget.data["yourSeat"] ?? 1;
    if (controller.players.isNotEmpty) {
      for (var p in controller.players) {
        if (p is Map) {
          final pId =
              p["userId"]?.toString() ??
              p["_id"]?.toString() ??
              p["id"]?.toString();
          if (pId != null && pId.isNotEmpty && pId == myUserId) {
            final pSeat = p["seat"] is int
                ? p["seat"]
                : int.tryParse(p["seat"]?.toString() ?? '');
            if (pSeat != null) {
              mySeat = pSeat;
              controller.mySeat = mySeat;
            }
            break;
          }
        }
      }
    }

    // 2. Map player seats to UI positions (0: Bottom, 1: Right, 2: Top, 3: Left)
    Map<int, Map<String, dynamic>> positionPlayers = {};

    for (var p in controller.players) {
      if (p is Map) {
        final pSeat = p["seat"] is int
            ? p["seat"]
            : int.tryParse(p["seat"]?.toString() ?? '');
        if (pSeat != null) {
          // Formula: (mySeat - pSeat + 4) % 4
          final int posIndex = ((mySeat - pSeat + 4) % 4).toInt();
          positionPlayers[posIndex] = Map<String, dynamic>.from(p);
        }
      }
    }

    // 3. Render PlayerProfileWidget for positions 0, 1, 2, 3
    return List.generate(4, (posIndex) {
      final playerMap = positionPlayers[posIndex];
      final bool isUser = (posIndex == 0);

      if (playerMap == null) {
        return Align(
          alignment: playerAlignments[posIndex],
          child: Opacity(
            opacity: 0.5,
            child: PlayerProfileWidget(
              name: "Waiting...",
              avatar: "p1",
              cardCount: 0,
              isUser: isUser,
            ),
          ),
        );
      }

      final String name = playerMap["name"]?.toString() ?? "Player";
      final String avatar = playerMap["avatar"]?.toString() ?? "p1";
      final String? flag = playerMap["flag"]?.toString();
      final int level = playerMap["level"] is int
          ? playerMap["level"]
          : int.tryParse(playerMap["level"]?.toString() ?? '') ?? 1;
      final int cardCount = playerMap["cardCount"] is int
          ? playerMap["cardCount"]
          : (isUser ? controller.handCards.length : 13);

      return Align(
        alignment: playerAlignments[posIndex],
        child: PlayerProfileWidget(
          name: name,
          avatar: avatar,
          flag: flag,
          level: level,
          cardCount: cardCount,
          isUser: isUser,
          cardsIcon: !isUser,
        ),
      );
    });
  }

  static const Map<int, Alignment> tableSpotAlignments = {
    0: Alignment(0.0, 0.22),
    // Bottom side of table (for Pos 0 / Me)
    1: Alignment(0.28, 0.02),
    // Right side of table (for Pos 1 / Right Player)
    2: Alignment(0.0, -0.22),
    // Top side of table (for Pos 2 / Top Player / Samne)
    3: Alignment(-0.28, 0.02),
    // Left side of table (for Pos 3 / Left Player)
  };

  void _handleCardPlayedSocket(Map data) {
    debugPrint(">> _handleCardPlayedSocket: $data");
    final Map card = data["card"] is Map
        ? Map<String, dynamic>.from(data["card"])
        : {};
    final int playedSeat = data["seat"] is int
        ? data["seat"]
        : int.tryParse(data["seat"]?.toString() ?? '') ?? -1;
    final String playedUserId = data["userId"]?.toString() ?? "";
    final String myUserId = controller.getUserData().id ?? "";

    if (playedSeat == -1) return;

    final int mySeat = controller.mySeat ?? widget.data["yourSeat"] ?? 1;
    final int posIndex = ((mySeat - playedSeat + 4) % 4).toInt();

    card["posIndex"] = posIndex;
    card["seat"] = playedSeat;

    final bool isMyCard =
        (playedUserId.isNotEmpty && playedUserId == myUserId) ||
        (playedSeat == controller.mySeat);

    if (isMyCard) {
      // Local user played card, already handled on tap
      return;
    }

    final Size size = MediaQuery.of(context).size;
    animateCardFromSeat(
      card: card,
      seatNumber: playedSeat,
      posIndex: posIndex,
      w: size.width,
      h: size.height,
    );
  }

  void animateCardFromSeat({
    required Map card,
    required int seatNumber,
    required int posIndex,
    required double w,
    required double h,
  }) {
    // Start Offset based on UI position
    Offset startOffset;
    switch (posIndex) {
      case 0: // Bottom (Me)
        startOffset = Offset(w * 0.5 - 42.5, h * 0.8);
        break;
      case 1: // Right
        startOffset = Offset(w * 0.88 - 42.5, h * 0.42);
        break;
      case 2: // Top (Samne)
        startOffset = Offset(w * 0.5 - 42.5, h * 0.12);
        break;
      case 3: // Left
        startOffset = Offset(w * 0.12 - 42.5, h * 0.42);
        break;
      default:
        startOffset = Offset(w * 0.5 - 42.5, h * 0.5);
    }

    // Target table spot for this player's position
    final Alignment targetAlignment =
        tableSpotAlignments[posIndex] ?? const Alignment(0, 0);
    const targetWidth = 85.0;
    const targetHeight = 95.0;

    final endOffset = Offset(
      (w / 2 + targetAlignment.x * w / 2) - targetWidth / 2,
      (h / 2 + targetAlignment.y * h / 2) - targetHeight / 2,
    );

    final animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    final animation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOutCubic,
    );

    final animCard = AnimatingCardModel(
      key: UniqueKey(),
      card: card,
      startOffset: startOffset,
      endOffset: endOffset,
      controller: animController,
      animation: animation,
    );

    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.tableCards.add(card);
        controller.update();
        if (mounted) {
          setState(() {
            _animatingCards.removeWhere((item) => item.key == animCard.key);
          });
        }
        animCard.controller.dispose();
      }
    });

    if (mounted) {
      setState(() {
        _animatingCards.add(animCard);
      });
    }
    animController.forward();
  }

  void _onHandCardTap(
    GameController controller,
    int index,
    Offset startOffset,
    double w,
    double h,
  ) {
    if (_animatingCards.isNotEmpty) return;
    if (!controller.isMyTurn) {
      controller.showMySnackBar("It's not your turn!", alert: true);
      return;
    }
    if (index < 0 || index >= controller.handCards.length) return;

    final Map card = Map<String, dynamic>.from(controller.handCards[index]);

    if (!controller.isCardPlayable(card)) {
      if (controller.firstChal) {
        controller.showMySnackBar(
          "First move must be Ace of Spades!",
          alert: true,
        );
      } else {
        controller.showMySnackBar(
          "You must play a ${controller.currentSuitName} card!",
          alert: true,
        );
      }
      return;
    }

    if (controller.firstChal) {
      controller.firstChal = false;
    }

    card["posIndex"] = 0; // My position is always 0 (Bottom)
    card["seat"] = controller.mySeat;

    controller.handCards.removeAt(index);
    controller.update();

    // Emit card play to socket server
    controller.onPlayCardEmit(card);

    const targetAlignment = Alignment(0.0, 0.22);
    const targetWidth = 85.0;
    const targetHeight = 95.0;

    final endOffset = Offset(
      (w / 2 + targetAlignment.x * w / 2) - targetWidth / 2,
      (h / 2 + targetAlignment.y * h / 2) - targetHeight / 2,
    );

    final animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    final animation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOutCubic,
    );

    final animCard = AnimatingCardModel(
      key: UniqueKey(),
      card: card,
      startOffset: startOffset,
      endOffset: endOffset,
      controller: animController,
      animation: animation,
    );

    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.tableCards.add(card);
        controller.update();
        if (mounted) {
          setState(() {
            _animatingCards.removeWhere((item) => item.key == animCard.key);
          });
        }
        animCard.controller.dispose();
      }
    });

    if (mounted) {
      setState(() {
        _animatingCards.add(animCard);
      });
    }
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => BackgroundWidget(
        opacity: 1,
        image: AppImages.gameBg2,
        padding: EdgeInsets.zero,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                ..._buildPlayerProfiles(controller),
                Positioned(
                  top: h * 0.25,
                  left: w * 0.2,
                  child: _buildDeckOnTable(),
                ),
                ..._buildCardsOnTable(controller.tableCards),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MyHandCard(
                    controller: controller,
                    onCardTap: (index, startOffset) =>
                        _onHandCardTap(controller, index, startOffset, w, h),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      controller.sortHandCards();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E8CFF), Color(0xFF1A52B8)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sort_rounded, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "SORT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ..._buildFlyingCards(
                  controller: controller,
                  w: w,
                  h: h,
                  cardWidth: 85,
                  cardHeight: 95,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildFlyingCards({
    required GameController controller,
    required double w,
    required double h,
    required double cardWidth,
    required double cardHeight,
  }) {
    return _animatingCards.map((animCard) {
      return AnimatedBuilder(
        animation: animCard.animation,
        builder: (context, child) {
          final t = animCard.animation.value;
          final curve = Curves.easeInOut.transform(t);

          final position = Offset.lerp(
            animCard.startOffset,
            animCard.endOffset,
            curve,
          )!;

          final arc = sin(pi * t) * -2;
          final rotatedPosition = position.translate(0, arc);

          final List<double> tableRotations = [0.05, -0.08, 0.03, -0.04];
          final targetRotation =
              tableRotations[controller.tableCards.length %
                  tableRotations.length];
          final rotation = lerpDouble(-0.02, targetRotation, t)!;

          final rawCard = animCard.card;
          final int cardValue = parseRank(rawCard["rank"] ?? rawCard["value"]);
          final Suit cardSuit = parseSuit(rawCard["suit"]);

          return Positioned(
            left: rotatedPosition.dx,
            top: rotatedPosition.dy,
            child: Transform.rotate(
              angle: rotation,
              child: PlayingCard(
                value: cardValue,
                suit: cardSuit,
                width: cardWidth,
                height: cardHeight,
                isTransform: true,
              ),
            ),
          );
        },
      );
    }).toList();
  }

  Widget _buildTopIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildDeckOnTable() {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: const Center(
            child: Text(
              "AIS",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCardsOnTable(List cards) {
    final int mySeat = controller.mySeat ?? widget.data["yourSeat"] ?? 1;

    return List.generate(cards.length, (index) {
      final rawCard = cards[index];

      int posIndex = 0;
      if (rawCard is Map && rawCard.containsKey("posIndex")) {
        posIndex = rawCard["posIndex"] as int;
      } else if (rawCard is Map && rawCard.containsKey("seat")) {
        final int cardSeat = rawCard["seat"] is int
            ? rawCard["seat"]
            : int.tryParse(rawCard["seat"]?.toString() ?? '') ?? mySeat;
        posIndex = ((mySeat - cardSeat + 4) % 4).toInt();
      } else {
        posIndex = index % 4;
      }

      final Alignment targetAlignment =
          tableSpotAlignments[posIndex] ?? const Alignment(0, 0);

      final List<double> tableRotations = [0.03, -0.04, 0.02, -0.03];
      final double rotation = tableRotations[posIndex % tableRotations.length];

      final int cardValue = parseRank(
        rawCard is Map
            ? (rawCard["rank"] ?? rawCard["value"])
            : (rawCard is List ? rawCard[0] : 1),
      );
      final Suit cardSuit = parseSuit(
        rawCard is Map
            ? rawCard["suit"]
            : (rawCard is List ? rawCard[1] : "spades"),
      );

      return Align(
        alignment: targetAlignment,
        child: Transform.rotate(
          angle: rotation,
          child: PlayingCard(
            value: cardValue,
            suit: cardSuit,
            width: 80,
            height: 90,
            isTransform: true,
          ),
        ),
      );
    });
  }
}
