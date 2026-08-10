import 'dart:math';
import 'dart:ui';
import '../../constant/export_file.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  // Ye list currently flying card animations ko rakhti hai.
  // Sirf ek animation ek time pe chalti hai, isliye agar ye khali nahi hai
  // toh naya tap ignore ho jayega.
  final List<AnimatingCardModel> _animatingCards = [];

  @override
  void dispose() {
    for (final animCard in _animatingCards) {
      animCard.controller.dispose();
    }
    super.dispose();
  }

  void _onHandCardTap(
    GameController controller,
    int index,
    Offset startOffset,
  ) {
    // Agar ek card already throw ho rahi hai toh dusre tap ko ignore karo.
    if (_animatingCards.isNotEmpty) return;
    if (index < 0 || index >= controller.handCards.length) return;

    final card = controller.handCards[index];
    controller.handCards.removeAt(index);
    controller.update();

    // Animation duration 900ms hai. Ye card ko startOffset se endOffset tak
    // curve ke saath move karega.
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
            const cardWidth = 82.0; // hand card aur flying card ki width
            const cardHeight = 80.0; // hand card aur flying card ki height

            // End destination: table ke beech ke bottom area mein card land kare.
            // Ye upar center pe nahi jaayega, balki neeche ki taraf hi rahega.
            final tableAlignment = const Alignment(-0.01, 0.3);

            final tableCenter = Offset(
              w / 2 + (w / 2) * tableAlignment.x,
              h / 2 + (h / 2) * tableAlignment.y,
            );

            final endOffset = Offset(
              tableCenter.dx - cardWidth / 2,
              tableCenter.dy - cardHeight / 2-5,
            );
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
                    cardCount: 10,
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
                        _onHandCardTap(controller, index, startOffset),
                  ),
                ),
                ..._buildFlyingCards(
                  w: w,
                  h: h,
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                  endOffset: endOffset,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildFlyingCards({
    required double w,
    required double h,
    required double cardWidth,
    required double cardHeight,
    required Offset endOffset,
  }) {
    return _animatingCards.map((animCard) {
      return AnimatedBuilder(
        animation: animCard.animation,
        builder: (context, child) {
          final t = animCard.animation.value;
          final curve = Curves.easeInOut.transform(t);

          // Start se end tak position interpolate ho rahi hai.
          // startOffset tapped hand card ke global screen coordinates hai.
          final position = Offset.lerp(animCard.startOffset, endOffset, curve)!;

          // Arc thoda downward hai taaki card zyada upar na jaye.
          // 6 pixel ka arc hai, isse card center ke upar nahi jaata.
          final arc = sin(pi * t) * -2;
          final rotatedPosition = position.translate(0, arc);

          // Card thoda rotate karegi jo realistic throw effect degi.
          // Shuruat mein -0.08 se lekar end pe +0.14 radians tak rotate hoti hai.
          final rotation = lerpDouble(-0.08, 0.00, t)!;

          // Scale animation thoda sa pulse deta hai.
          // Card flight mein 4% tak badi ho sakti hai mid-point pe.
          final scale = 1 + 0.3 * sin(pi * t); /// jaha se full screen per show karna hai jab thulla aayega

          return Positioned(
            left: rotatedPosition.dx,
            top: rotatedPosition.dy,
            child: Transform.rotate(
              angle: rotation,
              child: Transform.scale(
                scale: scale,
                child: PlayingCard(
                  value: animCard.card[0],
                  suit: animCard.card[1],
                  width: cardWidth,
                  height: cardHeight,
                ),
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
    final positions = [
      // const Alignment(-0.01, -0.4), // Top
      // const Alignment(-0.30, 0.07), // Left
      // const Alignment(0.30, 0.05), // Right
      const Alignment(-0.01, 0.3), // Bottom
    ];

    return List.generate(cards.length, (index) {
      final card = cards[index];
      return Align(
        alignment: positions[index % positions.length],
        child: PlayingCard(
          value: card[0],
          suit: card[1],
          width: 85,
          height: 95,
          isTransform: true,
        ),
      );
    });
  }
}

// // --- BUTTONS ---
// Positioned(
//   bottom: h * 0.22,
//   right: w * 0.04,
//   child: Row(
//     children: [
//       _buildGameButton("Sort", const Color(0xff29b6f6)),
//       const SizedBox(width: 10),
//       _buildChatButton(),
//     ],
//   ),
// ),
// // Card Count Badge
// if (cardCount > 0)
//   Positioned(
//     top: -2,
//     right: -6,
//     child: Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 4,
//         vertical: 1,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.yellow.shade700,
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(color: Colors.black, width: 1),
//       ),
//       child: Text(
//         cardCount.toString(),
//         style: const TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//     ),
//   ),
// // Winner Badge
// if (isWinner)
//   Positioned(
//     top: -22,
//     left: 0,
//     right: 0,
//     child: Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           decoration: BoxDecoration(
//             color: Colors.orange,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.black, width: 1),
//           ),
//           child: const Text(
//             "1st Winner",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 9,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const Icon(Icons.star, color: Colors.amber, size: 16),
//       ],
//     ),
//   ),
// // Status Icons (Mute/Eye)
// if (statusIcons != null)
//   Positioned(
//     left: -22,
//     top: 0,
//     child: Column(
//       children: statusIcons!
//           .map(
//             (icon) => Padding(
//           padding: const EdgeInsets.only(bottom: 2),
//           child: Icon(icon, color: Colors.white, size: 16),
//         ),
//       )
//           .toList(),
//     ),
//   ),
// Widget _buildGameButton(String text, Color color) {
//   return Container(
//     width: 100,
//     height: 45,
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [color.withValues(alpha: 0.7), color],
//       ),
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Colors.white, width: 2.5),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withValues(alpha: 0.3),
//           blurRadius: 4,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     ),
//     child: Center(
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w900,
//           fontSize: 22,
//           shadows: [Shadow(blurRadius: 2, offset: Offset(1, 1))],
//         ),
//       ),
//     ),
//   );
// }
//
// Widget _buildChatButton() {
//   return Container(
//     width: 45,
//     height: 45,
//     decoration: BoxDecoration(
//       color: Colors.amber,
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(color: Colors.white, width: 2.5),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withValues(alpha: 0.3),
//           blurRadius: 4,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     ),
//     child: const Icon(Icons.chat_bubble, color: Colors.white, size: 26),
//   );
// }
