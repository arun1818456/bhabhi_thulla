import '../../constant/export_file.dart';

class PlayerProfileWidget extends StatelessWidget {
  final String name;
  final String avatar;
  final String? flag;
  final int? level;
  final int cardCount;
  final bool isUser;
  final bool isWinner;
  final List<IconData>? statusIcons;
  final bool cardsIcon;

  const PlayerProfileWidget({
    super.key,
    required this.name,
    required this.avatar,
    this.flag,
    this.level,
    required this.cardCount,
    this.isUser = false,
    this.isWinner = false,
    this.statusIcons,
    this.cardsIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final String flagEmoji = _getFlagEmoji(flag);

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
                  border: Border.all(color: const Color(0xff29b6f6), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildAvatar(avatar),
                ),
              ),
            ),
            // FLAG EMOJI (TOP-LEFT)
            if (flag != null && flag!.isNotEmpty)
              Positioned(
                top: -3,
                left: -3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(flagEmoji, style: const TextStyle(fontSize: 10)),
                ),
              ),
            // LEVEL BADGE (TOP-RIGHT)
            if (level != null && level! > 0)
              Positioned(
                top: -3,
                right: -3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB34DFF), Color(0xFF5C1DAD)],
                    ),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFFFD85A), width: 1),
                  ),
                  child: Text(
                    "$level",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
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

  Widget _buildAvatar(String avatarKey) {
    if (avatarKey.startsWith("http://") || avatarKey.startsWith("https://")) {
      return Image.network(
        avatarKey,
        width: 38,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            Image.asset(AppImages.p1, width: 38, height: 40, fit: BoxFit.cover),
      );
    }
    if (AppImages.imageMap.containsKey(avatarKey)) {
      return Image.asset(
        AppImages.imageMap[avatarKey]!,
        width: 38,
        height: 40,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      avatarKey,
      width: 38,
      height: 40,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) =>
          Image.asset(AppImages.p1, width: 38, height: 40, fit: BoxFit.cover),
    );
  }

  String _getFlagEmoji(String? rawFlag) {
    if (rawFlag == null || rawFlag.trim().isEmpty) {
      return flags["IN"] ?? "🇮🇳";
    }
    final String cleanFlag = rawFlag.trim().toUpperCase();
    if (flags.containsKey(cleanFlag)) {
      return flags[cleanFlag]!;
    }
    return rawFlag;
  }
}
