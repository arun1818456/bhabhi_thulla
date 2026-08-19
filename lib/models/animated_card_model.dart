import '../constant/export_file.dart';

class AnimatingCardModel {
  final Key key;
  final List<dynamic> card;
  final Offset startOffset;
  final Offset endOffset;
  final AnimationController controller;
  final Animation<double> animation;

  AnimatingCardModel({
    required this.key,
    required this.card,
    required this.startOffset,
    required this.endOffset,
    required this.controller,
    required this.animation,
  });
}
