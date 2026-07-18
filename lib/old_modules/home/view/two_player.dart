import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/two_player_controller.dart';

class TwoPlayers extends StatefulWidget {
  const TwoPlayers({super.key});

  @override
  State<TwoPlayers> createState() => _TwoPlayersState();
}

class _TwoPlayersState extends State<TwoPlayers> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TwoPlayerController(),
      builder: (controller) {
        return Scaffold();
      },
    );
  }
}

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
