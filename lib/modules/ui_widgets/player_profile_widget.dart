import '../../constant/export_file.dart';

class PlayerProfileWidget extends StatelessWidget {
  final String name;
  final String avatar;
  final int cardCount;
  final bool isUser;
  final bool isWinner;
  final List<IconData>? statusIcons;
  final bool cardsIcon;

  const PlayerProfileWidget({
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
              duration: const Duration(seconds: 30),
              isRunning: true,
              borderRadius: 12,
              onCompleted: () {
                debugPrint("TIME OVER");
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xff29b6f6), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    avatar,
                    width: 38,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Container(
          constraints: const BoxConstraints(minWidth: 60, maxWidth: 120),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
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
