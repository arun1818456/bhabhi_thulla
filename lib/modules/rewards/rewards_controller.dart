import '../../constant/export_file.dart';

class RewardsController extends GetxController {
  List<RewardModel> dailyRewards = [
    RewardModel(day: 1, amount: 100, type: RewardType.coin),
    RewardModel(day: 2, amount: 200, type: RewardType.coin),
    RewardModel(day: 3, amount: 5, type: RewardType.diamond),
    RewardModel(day: 4, amount: 500, type: RewardType.coin),
    RewardModel(day: 5, amount: 10, type: RewardType.diamond),
    RewardModel(day: 6, amount: 1000, type: RewardType.coin),
    RewardModel(day: 7, amount: 1, type: RewardType.gift),
  ];

  List<MilestoneModel> milestones = [
    MilestoneModel(
      title: "Win 5 Solo Games",
      totalProgress: 5,
      currentProgress: 3,
      rewardAmount: 500,
      type: RewardType.coin,
    ),
    MilestoneModel(
      title: "Play 10 Friend Matches",
      totalProgress: 10,
      currentProgress: 7,
      rewardAmount: 20,
      type: RewardType.diamond,
    ),
    MilestoneModel(
      title: "Invite 3 Friends",
      totalProgress: 3,
      currentProgress: 1,
      rewardAmount: 1000,
      type: RewardType.coin,
    ),
    MilestoneModel(
      title: "Complete Daily Spin",
      totalProgress: 1,
      currentProgress: 1,
      rewardAmount: 2,
      type: RewardType.diamond,
    ),
    MilestoneModel(
      title: "Reach Level 10",
      totalProgress: 10,
      currentProgress: 8,
      rewardAmount: 5000,
      type: RewardType.coin,
    ),
  ];

  void claimDailyReward(int index) {
    if (!dailyRewards[index].isClaimed) {
      dailyRewards[index].isClaimed = true;
      update();
      Get.snackbar(
        "Reward Claimed!",
        "You got ${dailyRewards[index].amount} ${dailyRewards[index].type.name}s",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void claimMilestone(int index) {
    if (milestones[index].currentProgress >= milestones[index].totalProgress &&
        !milestones[index].isClaimed) {
      milestones[index].isClaimed = true;
      update();
      Get.snackbar(
        "Milestone Achieved!",
        "You claimed ${milestones[index].rewardAmount} ${milestones[index].type.name}s",
        backgroundColor: Colors.amber,
        colorText: Colors.white,
      );
    }
  }
}
