import '../constant/export_file.dart';

class AnimatingCardModel {
  final Key key;
  final List<dynamic> card;
  final Offset startOffset;
  final AnimationController controller;
  final Animation<double> animation;

  AnimatingCardModel({
    required this.key,
    required this.card,
    required this.startOffset,
    required this.controller,
    required this.animation,
  });
}
