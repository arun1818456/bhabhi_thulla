import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Drop-in widget.
/// Wrap any child to show a 30 second animated rounded timer border.
///
/// NOTE:
/// - Tick/countdown sounds are marked with TODOs. Plug in audioplayers if needed.
/// - Single file demo-ready widget.
class TurnTimer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isRunning;
  final double borderRadius;
  final VoidCallback? onCompleted;

  const TurnTimer({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 30),
    this.isRunning = true,
    this.borderRadius = 12,
    this.onCompleted,
  });

  @override
  State<TurnTimer> createState() => _TurnTimerState();
}

class _TurnTimerState extends State<TurnTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Timer? secondTimer;
  int remaining = 30;

  @override
  void initState() {
    super.initState();

    remaining = widget.duration.inSeconds;

    controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.isRunning) {
      _start();
    }
  }

  void _start() {
    controller.forward(from: 0);

    secondTimer?.cancel();

    secondTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      setState(() => remaining--);

      // TODO:
      // tick sound here

      if (remaining <= 5 && remaining > 0) {
        // TODO:
        // countdown sound
      }

      if (remaining <= 0) {
        t.cancel();

        // TODO:
        // timeout sound

        widget.onCompleted?.call();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TurnTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isRunning && !oldWidget.isRunning) {
      remaining = widget.duration.inSeconds;
      _start();
    }

    if (!widget.isRunning && oldWidget.isRunning) {
      controller.stop();
      secondTimer?.cancel();
    }
  }

  @override
  void dispose() {
    secondTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  Color get borderColor {
    if (remaining > 20) return Colors.green;
    if (remaining > 10) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, a) {
        final pulse = remaining <= 5
            ? 1 + (sin(controller.value * 40) * .06)
            : 1.0;

        return Transform.scale(
          scale: pulse,
          child: CustomPaint(
            painter: _BorderPainter(
              progress: controller.value,
              color: borderColor,
              radius: widget.borderRadius,
              glow: remaining <= 5,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class _BorderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double radius;
  final bool glow;

  _BorderPainter({
    required this.progress,
    required this.color,
    required this.radius,
    required this.glow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    final metric = path.computeMetrics().first;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = glow ? 5 : 4
      ..strokeCap = StrokeCap.round
      ..color = color;

    if (glow) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    }

    canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);

    final tangent = metric.getTangentForOffset(
      metric.length * progress.clamp(0, 1),
    );

    if (tangent != null) {
      canvas.drawCircle(
        tangent.position,
        glow ? 7 : 5,
        Paint()
          ..color = Colors.white
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );

      canvas.drawCircle(tangent.position, 4, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant _BorderPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.glow != glow;
}

/*
USAGE

TurnTimer(
  duration: const Duration(seconds:30),
  isRunning: true,
  borderRadius: 12,
  onCompleted: (){
    debugPrint("TIME OVER");
  },
  child: Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xff29b6f6),
        width: 2,
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        avatar,
        width: 50,
        height: 55,
        fit: BoxFit.fill,
      ),
    ),
  ),
);

*/
