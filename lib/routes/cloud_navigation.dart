import 'package:flutter/material.dart';

class CloudTransition {
  static Future navigate(
      BuildContext context,
      Widget page,
      ) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1600),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, secondaryAnimation) => page,
        transitionsBuilder:
            (_, animation, secondaryAnimation, child) {
          return Stack(
            children: [
              child,

              AnimatedBuilder(
                animation: animation,
                builder: (_, __) {
                  final value = animation.value;

                  double leftX;
                  double rightX;

                  // Clouds enter
                  if (value <= 0.5) {
                    final t = value * 2;

                    leftX = -350 + (350 * t);
                    rightX = -350 + (350 * t);
                  }
                  // Clouds exit
                  else {
                    final t = (value - 0.5) * 2;

                    leftX = 0 + (350 * t);
                    rightX = 0 + (350 * t);
                  }

                  return IgnorePointer(
                    child: Stack(
                      children: [
                        Positioned(
                          left: leftX,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(250),
                            ),
                          ),
                        ),

                        Positioned(
                          right: rightX,
                          top: 0,
                          bottom: 0,
                          child: Transform.flip(
                            flipX: true,
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(250),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}