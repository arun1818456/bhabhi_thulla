import 'dart:math' as math;
import '../constant/export_file.dart';

class CloudTransition {
  static Future push(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 1600),
        reverseTransitionDuration: const Duration(milliseconds: 1600),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return CloudAnimation(animation: animation, child: child);
        },
      ),
    );
  }
}

class _CloudParams {
  final Offset start;
  final Offset target;
  final Offset end;
  final double scale;
  final double opacity;
  final double startThreshold;
  final double endThreshold;
  final double phase;
  final double rotation;

  const _CloudParams({
    required this.start,
    required this.target,
    required this.end,
    required this.scale,
    this.opacity = 1.0,
    required this.startThreshold,
    required this.endThreshold,
    this.phase = 0.0,
    this.rotation = 0.0,
  });
}

class CloudAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const CloudAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final value = animation.value;

        return Stack(
          children: [
            // Switch the underlying page exactly in the middle of the
            // "full cover" hold window so the swap is hidden by clouds.
            Opacity(opacity: value > 0.5 ? 1.0 : 0.0, child: child),
            if (value > 0.0 && value < 1.0)
              ..._buildEnhancedClouds(context, value),
          ],
        );
      },
    );
  }

  List<Widget> _buildEnhancedClouds(BuildContext context, double value) {
    final size = MediaQuery.of(context).size;
    final List<Widget> clouds = [];
    final random = math.Random(123);

    final List<_CloudParams> cloudList = [];

    // Main grid: fewer, BIGGER, overlapping clouds mapped to a correct
    // -0.5..0.5 (screen-relative) coordinate space so they actually cover
    // the full viewport instead of overshooting it.
    const int rows = 10;
    const int cols = 13;

    // Slight overscan so edge clouds bleed past the screen border —
    // avoids any thin gap right at the edges.
    const double overscan = 0.62;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final double normX = (c / (cols - 1)) - 0.5; // -0.5 .. 0.5
        final double normY = (r / (rows - 1)) - 0.5; // -0.5 .. 0.5

        final double targetX = normX * (overscan / 0.5);
        final double targetY = normY * (overscan / 0.5);

        final jitterX = (random.nextDouble() - 0.5) * 0.06;
        final jitterY = (random.nextDouble() - 0.5) * 0.06;

        final double angle = random.nextDouble() * 2 * math.pi;
        final double startDist = 2.2 + random.nextDouble() * 0.8;
        final Offset startPos = Offset(
          math.cos(angle) * startDist,
          math.sin(angle) * startDist,
        );
        final Offset endPos = Offset(
          math.cos(angle + math.pi) * startDist,
          math.sin(angle + math.pi) * startDist,
        );

        // Diagonal position (0 = top-left, 1 = bottom-right) drives a
        // sweeping wave: clouds arrive and leave in a diagonal wipe,
        // just like the Clash of Clans loading transition.
        final double diag = (r + c) / (rows + cols - 2);

        cloudList.add(
          _CloudParams(
            start: startPos,
            target: Offset(targetX + jitterX, targetY + jitterY),
            end: endPos,
            scale: 0.24 + random.nextDouble() * 0.1,
            opacity: 0.97,
            startThreshold: 0.12 + diag * 0.22, // 0.12 -> 0.34
            endThreshold: 0.62 + diag * 0.22, // 0.62 -> 0.84
            phase: random.nextDouble() * 2 * math.pi,
            rotation: (random.nextDouble() - 0.5) * 0.25,
          ),
        );
      }
    }

    // A handful of extra soft background clouds for depth/parallax.
    for (int i = 0; i < 18; i++) {
      final double diag = random.nextDouble();
      cloudList.add(
        _CloudParams(
          start: Offset(
            random.nextDouble() * 4 - 2,
            random.nextDouble() * 4 - 2,
          ),
          target: Offset(
            random.nextDouble() * 1.3 - 0.65,
            random.nextDouble() * 1.3 - 0.65,
          ),
          end: Offset(random.nextDouble() * 4 - 2, random.nextDouble() * 4 - 2),
          scale: 0.18 + random.nextDouble() * 0.12,
          opacity: 0.55,
          startThreshold: 0.10 + diag * 0.20,
          endThreshold: 0.65 + diag * 0.20,
          phase: random.nextDouble() * 2 * math.pi,
          rotation: (random.nextDouble() - 0.5) * 0.3,
        ),
      );
    }

    for (var cloud in cloudList) {
      double t;
      Offset currentOffset;

      if (value < cloud.startThreshold) {
        t = value / cloud.startThreshold;
        final curveT = Curves.easeOutCubic.transform(t);
        currentOffset = Offset.lerp(cloud.start, cloud.target, curveT)!;
      } else if (value < cloud.endThreshold) {
        currentOffset = cloud.target;
      } else {
        t = (value - cloud.endThreshold) / (1.0 - cloud.endThreshold);
        final curveT = Curves.easeInCubic.transform(t);
        currentOffset = Offset.lerp(cloud.target, cloud.end, curveT)!;
      }

      final double pulse =
          1.0 + 0.12 * math.sin((value * 2.0 * math.pi) + cloud.phase);
      final double cloudWidth = size.width * cloud.scale * pulse;

      clouds.add(
        IgnorePointer(
          child: Transform.translate(
            offset: Offset(
              currentOffset.dx * size.width,
              currentOffset.dy * size.height,
            ),
            child: Center(
              child: Transform.rotate(
                angle: cloud.rotation,
                child: Image.asset(
                  AppImages.cloud,
                  width: cloudWidth,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                  color: Colors.white.withValues(alpha: cloud.opacity),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return clouds;
  }
}
