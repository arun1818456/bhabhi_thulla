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
    final bool isMyTurn = controller.isMyTurn;
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        const cardWidth = 68.0; // hand cards width

        if (cards.isEmpty) {
          return const SizedBox(height: 125, width: 0);
        }

        // Dynamic distance between cards based on available width
        final maxHandWidth = screenWidth * 0.7;
        double distance = 45.0;
        if (cards.length > 1 &&
            cardWidth + (cards.length - 1) * distance > maxHandWidth) {
          distance = (maxHandWidth - cardWidth) / (cards.length - 1);
        }

        final totalWidth = cards.length == 1
            ? cardWidth
            : cardWidth + (cards.length - 1) * distance;

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

              final rawCard = cards[index];
              final int cardValue = parseRank(
                rawCard["rank"] ?? rawCard["value"],
              );
              final Suit cardSuit = parseSuit(rawCard["suit"]);

              final bool isPlayable = controller.isCardPlayable(rawCard);
              final bool isHighlighted = isMyTurn && isPlayable;

              return Positioned(
                left: index * distance,
                bottom: -verticalOffset + (isHighlighted ? -18.0 : -25.0),
                child: Transform.rotate(
                  angle: rotation,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (details) {
                      if (!isMyTurn) {
                        controller.showMySnackBar("It's not your turn!", alert: true);
                      } else if (!isPlayable) {
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
                      } else {
                        onCardTap(
                          index,
                          details.globalPosition -
                              const Offset(cardWidth / 2, cardWidth / 2),
                        );
                      }
                    },
                    child: PlayingCard(
                      value: cardValue,
                      suit: cardSuit,
                      width: cardWidth,
                      height: 105,
                      isHighlighted: isHighlighted,
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
