import 'dart:math';
import 'dart:ui';
import '../../constant/export_file.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final List<AnimatingCardModel> _animatingCards = [];

  @override
  void dispose() {
    for (final animCard in _animatingCards) {
      animCard.controller.dispose();
    }
    super.dispose();
  }

  static const List<Alignment> tablePositions = [
    Alignment(-0.01, -0.4), // Top
    Alignment(-0.30, 0.07), // Left
    Alignment(0.30, 0.05), // Right
    Alignment(-0.01, 0.3), // Bottom
  ];

  void _onHandCardTap(
    GameController controller,
    int index,
    Offset startOffset,
    double w,
    double h,
  ) {
    if (_animatingCards.isNotEmpty) return;
    if (index < 0 || index >= controller.handCards.length) return;

    final card = controller.handCards[index];
    controller.handCards.removeAt(index);
    controller.update();

    final targetAlignment =
        tablePositions[controller.onTableThrowCards.length % tablePositions.length];
    const targetWidth = 85.0;
    const targetHeight = 95.0;

    final endOffset = Offset(
      (w / 2 + targetAlignment.x * w / 2) - targetWidth / 2,
      (h / 2 + targetAlignment.y * h / 2) - targetHeight / 2,
    );

    final animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
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
        controller.onTableThrowCards.add(card);
        controller.update();
        setState(() {
          _animatingCards.removeWhere((item) => item.key == animCard.key);
        });
        animCard.controller.dispose();
      }
    });

    setState(() {
      _animatingCards.add(animCard);
    });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GameController(),
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
                Positioned(
                  top: 10,
                  left: 10,
                  child: _buildTopIcon(Icons.wifi_off, Colors.red),
                ),
                Align(
                  alignment: const Alignment(0, -0.9),
                  child: PlayerProfileWidget(
                    name: "Honey hr02",
                    avatar: AppImages.p1,
                    cardCount: 0,
                    isWinner: true,
                    statusIcons: [Icons.speaker_notes_off, Icons.visibility],
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.88, -0.15),
                  child: PlayerProfileWidget(
                    name: "Aa",
                    avatar: AppImages.p2,
                    cardCount: 13,
                    statusIcons: [Icons.speaker_notes_off],
                    cardsIcon: true,
                  ),
                ),
                Align(
                  alignment: const Alignment(0.88, -0.15),
                  child: PlayerProfileWidget(
                    name: "A964",
                    avatar: AppImages.p3,
                    cardCount: 11,
                    statusIcons: [Icons.speaker_notes_off],
                    cardsIcon: true,
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.88, 0.7),
                  child: PlayerProfileWidget(
                    name: "arun",
                    avatar: AppImages.p8,
                    cardCount: controller.handCards.length,
                    isUser: true,
                  ),
                ),
                Positioned(
                  top: h * 0.25,
                  left: w * 0.2,
                  child: _buildDeckOnTable(),
                ),
                ..._buildCardsOnTable(controller.onTableThrowCards),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MyHandCard(
                    controller: controller,
                    onCardTap: (index, startOffset) =>
                        _onHandCardTap(controller, index, startOffset, w, h),
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

          final position =
              Offset.lerp(animCard.startOffset, animCard.endOffset, curve)!;

          final arc = sin(pi * t) * -2;
          final rotatedPosition = position.translate(0, arc);

          final List<double> tableRotations = [0.05, -0.08, 0.03, -0.04];
          final targetRotation =
              tableRotations[controller.onTableThrowCards.length % tableRotations.length];
          final rotation = lerpDouble(-0.02, targetRotation, t)!;

          return Positioned(
            left: rotatedPosition.dx,
            top: rotatedPosition.dy,
            child: Transform.rotate(
              angle: rotation,
              child: PlayingCard(
                value: animCard.card[0],
                suit: animCard.card[1],
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
    return List.generate(cards.length, (index) {
      final card = cards[index];
      final List<double> tableRotations = [0.05, -0.08, 0.03, -0.04];
      final double rotation = tableRotations[index % tableRotations.length];

      return Align(
        alignment: tablePositions[index % tablePositions.length],
        child: Transform.rotate(
          angle: rotation,
          child: PlayingCard(
            value: card[0],
            suit: card[1],
            width: 85,
            height: 95,
            isTransform: true,
          ),
        ),
      );
    });
  }
}
