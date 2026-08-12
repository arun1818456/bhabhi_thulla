import 'package:bhabhi_thulla/constant/export_file.dart';
import '../../models/rank_model.dart';

class RanksController extends GetxController {
  List<RankModel> ranks = [
    RankModel(rank: 1, name: "Arun Kumar", score: 25400, level: 42, avatar: AppImages.p9),
    RankModel(rank: 2, name: "Vikram Singh", score: 22100, level: 38, avatar: AppImages.p10),
    RankModel(rank: 3, name: "Neha Kapoor", score: 19800, level: 35, avatar: AppImages.p12),
    RankModel(rank: 4, name: "Rahul Sharma", score: 15400, level: 28, avatar: AppImages.p1),
    RankModel(rank: 5, name: "Saurav Singh", score: 12100, level: 25, avatar: AppImages.p3),
    RankModel(rank: 6, name: "Amit Patel", score: 9800, level: 21, avatar: AppImages.p4),
    RankModel(rank: 7, name: "Vijay Verma", score: 8400, level: 18, avatar: AppImages.p5),
    RankModel(rank: 8, name: "Prakash Deep", score: 7100, level: 15, avatar: AppImages.p6),
    RankModel(rank: 9, name: "Suraj Kumar", score: 5800, level: 12, avatar: AppImages.p7),
    RankModel(rank: 10, name: "Deepak Raj", score: 4400, level: 10, avatar: AppImages.p8),
  ];
}
