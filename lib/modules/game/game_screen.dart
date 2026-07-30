import 'package:bhabhi_thulla/modules/game/game_controller.dart';
import 'package:bhabhi_thulla/widgets/player_turn_timer.dart';

import '../../constant/export_file.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GameController(),
      builder: (controller) => BackgroundWidget(
        opacity: 1,
        image: AppImages.gameBg,
        padding: EdgeInsets.zero,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;

            return Stack(
              children: [

                Positioned(
                  top: 10,
                  left: 10,
                  child: _buildTopIcon(Icons.wifi_off, Colors.red),
                ),


                Align(
                  alignment: const Alignment(0, -0.9),
                  child: PlayerWidget(
                    name: "Honey hr02",
                    avatar: AppImages.p1,
                    cardCount: 0,
                    isWinner: true,
                    statusIcons: [Icons.speaker_notes_off, Icons.visibility],
                  ),
                ),
                // Left Player
                Align(
                  alignment: const Alignment(-0.88, -0.15),
                  child: PlayerWidget(
                    name: "Aa",
                    avatar: AppImages.p2,
                    cardCount: 13,
                    statusIcons: [Icons.speaker_notes_off],
                    cardsIcon: true,
                  ),
                ),
                // Right Player
                Align(
                  alignment: const Alignment(0.88, -0.15),
                  child: PlayerWidget(
                    name: "A964",
                    avatar: AppImages.p3,
                    cardCount: 11,
                    statusIcons: [Icons.speaker_notes_off],
                    cardsIcon: true,
                  ),
                ),
                // Bottom Left (User arun)
                Align(
                  alignment: const Alignment(-0.88, 0.7),
                  child: PlayerWidget(
                    name: "arun",
                    avatar: AppImages.p8,
                    cardCount: 10,
                    isUser: true,
                  ),
                ),

                // --- TABLE CARDS (Deck) ---
                Positioned(
                  top: h * 0.25,
                  left: w * 0.2,
                  child: _buildDeckOnTable(),
                ),

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

                // --- CARDS HAND ---
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CardHand(),
                ),
              ],
            );
          },
        ),
      ),
    );
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

  Widget _buildGameButton(String text, Color color) {
    return Container(
      width: 100,
      height: 45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.7), color],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            shadows: [Shadow(blurRadius: 2, offset: Offset(1, 1))],
          ),
        ),
      ),
    );
  }

  Widget _buildChatButton() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(Icons.chat_bubble, color: Colors.white, size: 26),
    );
  }
}

class PlayingCard extends StatelessWidget {
  final String value;
  final String suit;
  final Color color;

  const PlayingCard({
    super.key,
    required this.value,
    required this.suit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .6),
            blurRadius: 4,
            offset: const Offset(-2, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            left: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: color,
                    height: 1,
                  ),
                ),
                Text(
                  suit,
                  style: TextStyle(fontSize: 18, color: color, height: 1),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(suit, style: TextStyle(fontSize: 42, color: color)),
            ),
          ),
        ],
      ),
    );
  }
}

class CardHand extends StatelessWidget {
  CardHand({super.key});

  final List<List<dynamic>> cards = [
    ["5", "♦", Colors.red],
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = MediaQuery.of(context).size.width;
        const cardWidth = 68.0;

        // Dynamic distance between cards based on available width
        final maxHandWidth = w * 0.7;
        double distance = 45.0;
        if (cardWidth + (cards.length - 1) * distance > maxHandWidth) {
          distance = (maxHandWidth - cardWidth) / (cards.length - 1);
        }

        final totalWidth = cardWidth + (cards.length - 1) * distance;

        return SizedBox(
          height: 125,
          width: totalWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(cards.length, (index) {
              final middleIndex = (cards.length - 1) / 2;
              final relativeIndex = index - middleIndex;

              // Fan effect
              final rotation = relativeIndex * 0.02;
              final verticalOffset = (relativeIndex.abs() * 2.6);

              return Positioned(
                left: index * distance,
                bottom: -verticalOffset-15,
                child: Transform.rotate(
                  angle: rotation,
                  child: PlayingCard(
                    value: cards[index][0] as String,
                    suit: cards[index][1] as String,
                    color: cards[index][2] as Color,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String name;
  final String avatar;
  final int cardCount;
  final bool isUser;
  final bool isWinner;
  final List<IconData>? statusIcons;
  final bool cardsIcon;

  const PlayerWidget({
    super.key,
    required this.name,
    required this.avatar,
    required this.cardCount,
    this.isUser = false,
    this.isWinner = false,
    this.statusIcons,
    this.cardsIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            TurnTimer(
              duration: const Duration(seconds:30),
              isRunning: true,
              borderRadius: 12,
              onCompleted: (){
                debugPrint("TIME OVER");
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:  Color(0xff29b6f6),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    avatar,
                    width: 50,
                    height: 55,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
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
          ],
        ),
        const SizedBox(height: 3),
        Container(
          constraints: const BoxConstraints(
            minWidth: 60,
            maxWidth: 120,
          ),
          // width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
