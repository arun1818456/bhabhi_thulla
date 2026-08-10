import '../../constant/enums.dart';
import '../../constant/export_file.dart';

class PlayingCard extends StatelessWidget {
  final int value;
  final Suit suit;
  final double width;
  final double height;
  final bool isTransform;

  const PlayingCard({
    super.key,
    required this.value,
    required this.suit,
    this.width = 100,
    this.height = 110,
    this.isTransform = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: width,
      height: height,
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
            left: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$value",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: suit == Suit.spades || suit == Suit.clubs
                        ? Colors.black
                        : Color(0xFF8C0505),
                    height: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Image.asset(
                  suit == Suit.spades
                      ? AppImages.spades
                      : suit == Suit.hearts
                      ? AppImages.hearts
                      : suit == Suit.diamonds
                      ? AppImages.diamonds
                      : AppImages.clubs,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(height: 3),
                // Text(
                //   "suit",
                //   style: TextStyle(
                //     fontSize: width * 0.2,
                //     color: Colors.black,
                //     height: 1,
                //   ),
                // ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 5),
          //     child: Text(
          //       "$suit",
          //       style: TextStyle(fontSize: width * 0.42, color: Colors.black),
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    // Transform sirf true hone par
    if (isTransform) {
      return Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0025)
          ..rotateX(-0.50),
        child: card,
      );
    }

    // Normal card
    return card;
  }
}
