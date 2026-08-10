import 'package:bhabhi_thulla/constant/enums.dart';

import '../../constant/export_file.dart';

class MyHandCard extends StatelessWidget {
  const MyHandCard({
    super.key,
    required this.controller,
    required this.onCardTap,
  });
  final GameController controller;
  final void Function(int index, Offset startOffset) onCardTap;

  @override
  Widget build(BuildContext context) {
    final cards = controller.handCards;
    final screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        const cardWidth = 68.0; // hand cards ka width

        // Dynamic distance between cards based on available width
        final maxHandWidth = screenWidth * 0.7;
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
              final rotation = relativeIndex * 0.018;
              final verticalOffset = (relativeIndex.abs() * 2.6);

              return Positioned(
                left: index * distance,
                bottom: -verticalOffset - 25,
                child: Transform.rotate(
                  angle: rotation,
                  child: GestureDetector(
                    // Hand card par tap hone pe exact global coordinate capture karo.
                    // Ye coordinate flying card ka start point banega.
                    onTapDown: (details) {
                      onCardTap(
                        index,
                        details.globalPosition -
                            const Offset(cardWidth / 2, cardWidth / 2),
                      );
                    },
                    onTap: () {},
                    child: PlayingCard(
                      value: cards[index][0] as int,
                      suit: cards[index][1],
                    ),
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
