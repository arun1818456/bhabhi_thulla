import 'dart:ui';

import 'package:bhabhi_thulla/constant/images_text.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;

  const BackgroundWidget({
    super.key,
    this.child,
    this.appBar,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.background,
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ),
            child: Container(
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: padding??EdgeInsets.all(10),
                child: child ?? Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}