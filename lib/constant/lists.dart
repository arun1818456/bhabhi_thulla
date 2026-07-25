import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:playing_cards/playing_cards.dart';

//new

List  profileDataList = [
  {"title":"GAMES PLAYED","value":"12","image":AppImages.game,"p":false},
  {"title":"GAMES WON","value":"12","image":AppImages.won,"p":false},
  {"title":"WIN RATE","value":"12","image":AppImages.winTarget,"p":true},
  {"title":"QUIT RATE","value":"12","image":AppImages.exit,"p":true},
  {"title":"BHABHI COUNT","value":"12","image":AppImages.bhabhi,"p":false},
  {"title":"THULLA COUNT","value":"12","image":AppImages.thulla,"p":false},
  {"title":"WIN STREAK","value":"12","image":AppImages.winStreak,"p":false},
  {"title":"BEST WIN","value":"12","image":AppImages.bestWin,"p":false},
];

List profileLists=[
  AppImages.p1,
  AppImages.p2,
  AppImages.p3,
  AppImages.p4,
  AppImages.p5,
  AppImages.p6,
  AppImages.p7,
  AppImages.p8,
  AppImages.p9,
  AppImages.p10,
  AppImages.p11,
  AppImages.p12,
  AppImages.p13,
  AppImages.p14,
  AppImages.p15,
  AppImages.p16,
  AppImages.p17,
  AppImages.p18,
  AppImages.p19,
  AppImages.p20,
];

final List<String> profileOptions = [
  AppImages.profile,
  AppImages.avatar,
  AppImages.theme,
  AppImages.emojis,
  AppImages.cards,
];


// past

final List<CardValue> ranks = [
  CardValue.ace,
  CardValue.two,
  CardValue.three,
  CardValue.four,
  CardValue.five,
  CardValue.six,
  CardValue.seven,
  CardValue.eight,
  CardValue.nine,
  CardValue.ten,
  CardValue.jack,
  CardValue.queen,
  CardValue.king
];
final List<Suit> suits = [
  Suit.spades,
  Suit.hearts,
  Suit.diamonds,
  Suit.clubs
];