import 'dart:math';
import 'dart:ui' as ui;

import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:bhabhi_thulla/modules/splash/splash_controller.dart';
import 'package:spinning_wheel/controller/spin_controller.dart';
import 'package:spinning_wheel/models/wheel_label_style.dart';
import 'package:spinning_wheel/models/wheel_segment.dart';
import 'package:spinning_wheel/spinner_wheel.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen>
    with TickerProviderStateMixin {
  final SpinnerController controller = SpinnerController();

  late final List<WheelSegment> segments;
  ui.Image? coinImage;
  late AnimationController shakeController;
  late Animation<double> shakeAnimation;
  bool isSpinning = false;

  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();

    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5),
    );

    shakeAnimation = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(parent: shakeController, curve: Curves.easeInOut),
    );

    shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        shakeController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (isSpinning) {
          shakeController.forward();
        }
      }
    });
    
    // Use the pre-cached image from SplashController
    coinImage = SplashController.coinUiImage;

    segments = [
      WheelSegment(
        "Jackpot!",
        1000,
        color: Colors.orange,
        probability: 0.05,
        image: coinImage,
      ),
      WheelSegment("Prize 2", 20, color: Colors.blue, probability: 0.30),
      WheelSegment("Gift", 100, color: Colors.green, probability: 0.45),
      WheelSegment("Empty", 0, color: Colors.grey, probability: 0.20),
      WheelSegment("Empty", 0, color: Colors.orange, probability: 0.20),
      WheelSegment("Empty", 0, color: Colors.red, probability: 0.20),
      WheelSegment("Empty", 0, color: Colors.blue, probability: 0.20),
    ];
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 20),
    );
    _controllerCenterRight = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    _controllerCenterLeft = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    _controllerBottomCenter = ConfettiController(
      duration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 50,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: shakeController,
                    builder: (_, child) {
                      return Transform.translate(
                        offset: Offset(shakeAnimation.value, 0),
                        child: child,
                      );
                    },
                    child: SpinnerWheel(
                      controller: controller,
                      segments: segments,
                      slicePadding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      labelStyle: const WheelLabelStyle(
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        angle: 0,
                      ),
                      onComplete: (result, index) {
                        _controllerCenter.stop();
                        _controllerCenter.play();

                        _controllerCenterRight.stop();
                        _controllerCenterRight.play();

                        _controllerCenterLeft.stop();
                        _controllerCenterLeft.play();

                        _controllerBottomCenter.stop();
                        _controllerBottomCenter.play();
                        isSpinning = false;
                        debugPrint("You won: ${result.label}");
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  isSpinning = true;
                  shakeController.forward();
                  controller.startSpin();
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      isSpinning = false;
                      shakeController.stop();
                      shakeController.reset();
                    }
                  });
                },
                child: const Text("Spin"),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ], // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              blastDirection: pi, // radial value - LEFT
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
              ], // manually specify the colors to be used
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerCenterLeft,
              blastDirection: 0, // radial value - RIGHT
              emissionFrequency: 0.6,
              // set the minimum potential size for the confetti (width, height)
              minimumSize: const Size(10, 10),
              // set the maximum potential size for the confetti (width, height)
              maximumSize: const Size(50, 50),
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    shakeController.dispose();
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }

  void loadUiImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);

    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());

    final frame = await codec.getNextFrame();

    coinImage = frame.image;
  }
}
