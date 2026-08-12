enum RewardType { coin, diamond, gift }

class RewardModel {
  final int day;
  final int amount;
  final RewardType type;
  bool isClaimed;

  RewardModel({
    required this.day,
    required this.amount,
    required this.type,
    this.isClaimed = false,
  });
}

class MilestoneModel {
  final String title;
  final int totalProgress;
  int currentProgress;
  final int rewardAmount;
  final RewardType type;
  bool isClaimed;

  MilestoneModel({
    required this.title,
    required this.totalProgress,
    this.currentProgress = 0,
    required this.rewardAmount,
    required this.type,
    this.isClaimed = false,
  });

  double get progressValue => (currentProgress / totalProgress).clamp(0.0, 1.0);
}
