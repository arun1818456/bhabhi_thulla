import 'dart:ui';

import 'package:bhabhi_thulla/constant/app_images.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final String? image;
  final double? opacity;
  const BackgroundWidget({
    super.key,
    this.child,
    this.appBar,
    this.padding,
    this.image,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image ?? AppImages.background,
              opacity: AlwaysStoppedAnimation(opacity ?? .7),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: padding ?? EdgeInsets.all(10),
                child: child ?? Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
