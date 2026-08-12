import '../../constant/export_file.dart';
import '../../models/rank_model.dart';

class RanksScreen extends StatelessWidget {
  const RanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RanksController>(
      init: RanksController(),
      builder: (controller) {
        final top3 = controller.ranks.take(3).toList();
        final others = controller.ranks.skip(3).toList();

        return Container(
          margin: const EdgeInsets.only(top: 30),
          height: Get.height * 0.75,
          width: Get.width * 0.95,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  // --- LEFT SIDE: Podium (Top 3) ---
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const MyText(text: "Top Winners", fontSize: 22, borderWidth: 3),
                          const Spacer(),
                          SizedBox(
                            height: constraints.maxHeight * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (top3.length > 1) 
                                  _podiumItem(top3[1], Colors.grey.shade400, constraints.maxHeight * 0.5, AppImages.starCard),
                                const SizedBox(width: 10),
                                if (top3.isNotEmpty) 
                                  _podiumItem(top3[0], Colors.amber, constraints.maxHeight * 0.65, AppImages.starCard, isWinner: true),
                                const SizedBox(width: 10),
                                if (top3.length > 2) 
                                  _podiumItem(top3[2], Colors.orange.shade700, constraints.maxHeight * 0.45, AppImages.starCard),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),

                  // Vertical Divider
                  Container(
                    width: 2,
                    height: constraints.maxHeight * 0.8,
                    color: Colors.amber.withValues(alpha: 0.3),
                  ),

                  // --- RIGHT SIDE: Leaderboard List ---
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: MyText(text: "Global Leaderboard", fontSize: 22, borderWidth: 3),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemCount: others.length,
                            itemBuilder: (context, index) {
                              final player = others[index];
                              return AnimatorWidget(
                                effect: AnimationEffect.rightToLeft,
                                delay: Duration(milliseconds: 50 * index),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.profileCard),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      MyText(text: player.rank.toString(), fontSize: 18, color: Colors.brown),
                                      const SizedBox(width: 15),
                                      Container(
                                        width: 38,
                                        height: 38,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppImages.profileBgCard),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        child: Image.asset(player.avatar, fit: BoxFit.contain),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(child: MyText(text: player.name, fontSize: 16, color: Colors.brown, borderColor: Colors.transparent)),
                                            FittedBox(child: MyText(text: "Level ${player.level}", fontSize: 10, color: Colors.brown.shade400, borderColor: Colors.transparent)),
                                          ],
                                        ),
                                      ),
                                      MyText(text: player.score.toString(), fontSize: 16, color: Colors.orange.shade800),
                                      SizedBox(width: 25,)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _podiumItem(RankModel player, Color color, double totalHeight, String bg, {bool isWinner = false}) {
    final avatarSize = totalHeight * (isWinner ? 0.45 : 0.4);
    final baseHeight = totalHeight - avatarSize - 10;

    return AnimatorWidget(
      effect: AnimationEffect.scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                padding: EdgeInsets.all(avatarSize * 0.08),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: isWinner ? 3 : 2),
                  boxShadow: [
                    BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 15, spreadRadius: 2),
                  ],
                ),
                child: ClipOval(child: Image.asset(player.avatar, fit: BoxFit.cover)),
              ),
              Positioned(
                bottom: -avatarSize * 0.05,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Text(
                    player.rank.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                      fontSize: avatarSize * 0.22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: isWinner ? 90 : 75,
            height: baseHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color, color.withValues(alpha: 0.6)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MyText(
                      text: player.name, 
                      fontSize: isWinner ? 12 : 10, 
                      borderColor: Colors.transparent,
                    ),
                  ),
                ),
                Flexible(
                  child: MyText(
                    text: player.score.toString(), 
                    fontSize: isWinner ? 14 : 12, 
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
