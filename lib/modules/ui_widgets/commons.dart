import '../../constant/export_file.dart';

Widget headerChip(String icon, String value, Color iconColor) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.centerLeft,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.only(left: 30, right: 5),
        decoration: BoxDecoration(
          color: Colors.black87.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 20,
              width: 20,
              child: Icon(
                Icons.add,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                size: 15,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        child: SizedBox(height: 30, width: 35, child: Image.asset(icon)),
      ),
    ],
  );
}

class RankProgressWidget extends StatelessWidget {
  final int current;
  final int total;

  const RankProgressWidget({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    double progress = current / total;

    return SizedBox(
      height: 50,
      width: 190,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 15,
            child: Container(
              width: 165,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xff6B3307),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xff3D1800), width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    /// Progress
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffD962FF),
                              Color(0xffA336F5),
                              Color(0xff7B19D9),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Text
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$current",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Color(0xff3A1476),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            const TextSpan(
                              text: " / ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "$total",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF6E5C2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Star
          Positioned(
            left: 8,
            child: Image.asset(AppImages.starCard, width: 40, height: 40),
          ),
        ],
      ),
    );
  }
}
