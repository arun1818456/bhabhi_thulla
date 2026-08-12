import 'package:bhabhi_thulla/modules/rewards/rewards_controller.dart';
import '../../constant/export_file.dart';
import '../../models/reward_model.dart';
import '../../widgets/animation_effect.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(
      init: RewardsController(),
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          height: Get.height * 0.75,
          width: Get.width * 0.95,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily Rewards Section (More compact)
                  SizedBox(
                    height: availableHeight * 0.28,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: controller.dailyRewards.length,
                      itemBuilder: (context, index) {
                        final reward = controller.dailyRewards[index];
                        return AnimatorWidget(
                          effect: AnimationEffect.scale,
                          delay: Duration(milliseconds: 50 * index),
                          child: _dailyRewardCard(reward, index, controller, availableHeight * 0.28),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 15),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: MyText(text: "Milestones", fontSize: 20, borderWidth: 3),
                  ),
                  
                  const SizedBox(height: 10),

                  // Milestones Grid (2 items per row)
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.2, // Adjusted for two items per row
                      ),
                      itemCount: controller.milestones.length,
                      itemBuilder: (context, index) {
                        final milestone = controller.milestones[index];
                        return AnimatorWidget(
                          effect: AnimationEffect.bottomToTop,
                          delay: Duration(milliseconds: 80 * index),
                          child: _milestoneCard(milestone, index, controller),
                        );
                      },
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

  Widget _dailyRewardCard(RewardModel reward, int index, RewardsController controller, double totalHeight) {
    bool isToday = index == 3;
    
    return GestureDetector(
      onTap: () => controller.claimDailyReward(index),
      child: Container(
        width: 85,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: reward.isClaimed ? Colors.grey.shade900.withValues(alpha: 0.8) : (isToday ? Colors.amber.shade900 : Colors.brown.shade800),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isToday ? Colors.amberAccent : Colors.amber.withValues(alpha: 0.4),
            width: isToday ? 2.5 : 1.2,
          ),
          boxShadow: isToday ? [BoxShadow(color: Colors.amber.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 1)] : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyText(text: "Day ${reward.day}", fontSize: 12, borderColor: Colors.transparent),
            Image.asset(
              reward.type == RewardType.coin ? AppImages.coin : (reward.type == RewardType.diamond ? AppImages.diamond : AppImages.gift),
              width: 32,
              height: 32,
            ),
            MyText(text: "${reward.amount}", fontSize: 14),
            if (reward.isClaimed)
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _milestoneCard(MilestoneModel milestone, int index, RewardsController controller) {
    bool canClaim = milestone.currentProgress >= milestone.totalProgress && !milestone.isClaimed;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.25), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.brown.shade900,
              shape: BoxShape.circle,
            ),
            child: Icon(
              milestone.type == RewardType.coin ? Icons.monetization_on : Icons.diamond,
              color: Colors.amber,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(child: MyText(text: milestone.title, fontSize: 13, borderColor: Colors.transparent)),
                const SizedBox(height: 5),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: milestone.progressValue,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.orange, Colors.amber]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                MyText(
                  text: "${milestone.currentProgress}/${milestone.totalProgress}",
                  fontSize: 9,
                  color: Colors.white70,
                  borderColor: Colors.transparent,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(text: "${milestone.rewardAmount}", fontSize: 11, color: Colors.amberAccent),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: canClaim ? () => controller.claimMilestone(index) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: milestone.isClaimed ? Colors.grey.shade700 : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: MyText(
                  text: milestone.isClaimed ? "Claimed" : "Claim",
                  fontSize: 9,
                  borderColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
