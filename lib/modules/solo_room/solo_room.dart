import 'dart:math' as math;
import '../../constant/export_file.dart';

class SoloRoom extends StatelessWidget {
  const SoloRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SoloRoomController(),
      builder: (controller) => controller.prizeSelected != null
          ? MatchCenterRow()
          : SizedBox(
              height: Get.height / 2 + 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.rooms.length,
                itemBuilder: (context, index) {
                  final room = controller.rooms[index];
                  return AnimatorWidget(
                    effect: AnimationEffect.scale,
                    child: GestureDetector(
                      onTap: () {
                        controller.onTapToSelectPrize(room.entryFee);
                      },
                      child: FlipRoomCard(room: room),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class FlipRoomCard extends StatefulWidget {
  final GameRoom room;

  const FlipRoomCard({super.key, required this.room});

  @override
  State<FlipRoomCard> createState() => _FlipRoomCardState();
}

class _FlipRoomCardState extends State<FlipRoomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, a) {
        final angle = _controller.value * math.pi;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: angle <= math.pi / 2
              ? _frontCard()
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: _backCard(),
                ),
        );
      },
    );
  }

  Widget _frontCard() {
    return _card(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: flipCard,
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Icon(Icons.info, color: Colors.white, size: 18),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(text: "Prize", fontSize: 20),
                      MyText(text: widget.room.prize.toString(), fontSize: 35),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                MyText(text: "Entry Fee", fontSize: 15),

                MyText(text: widget.room.entryFee.toString(), fontSize: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _backCard() {
    return _card(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: flipCard,
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  text: "Prizes",
                  color: Colors.orange,
                  borderWidth: 1.5,
                  borderColor: Colors.white,
                  fontSize: 22,
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "1st",
                      fontSize: 18,
                      borderColor: Colors.orangeAccent,
                      borderWidth: 1.5,
                    ),
                    SizedBox(width: 5),
                    Image.asset(AppImages.coin, width: 20, height: 20),
                    SizedBox(width: 5),
                    MyText(
                      text: "${widget.room.prize}",
                      fontSize: 18,
                      borderColor: Colors.orangeAccent,
                      borderWidth: 1.5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "2nd",
                      fontSize: 18,
                      borderColor: Colors.orangeAccent,
                      borderWidth: 1.5,
                    ),
                    SizedBox(width: 5),
                    Image.asset(AppImages.coin, width: 20, height: 20),
                    SizedBox(width: 5),
                    MyText(
                      text: "${widget.room.prize}",
                      fontSize: 18,
                      borderColor: Colors.orangeAccent,
                      borderWidth: 1.5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "3rd",
                      fontSize: 18,
                      borderColor: Colors.orangeAccent,
                      borderWidth: 1.5,
                    ),
                    SizedBox(width: 5),
                    Image.asset(AppImages.coin, width: 20, height: 20),
                    SizedBox(width: 5),
                    MyText(
                      text: "${widget.room.prize}",
                      fontSize: 18,
                      borderColor: Colors.orangeAccent,
                      borderWidth: 1.5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: child,
    );
  }
}

class MatchCenterRow extends StatelessWidget {
  const MatchCenterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// PLAYER
              PlayerCard(playerName: "ARUN", isMe: true),

              SizedBox(width: size.width * .03),

              /// VS
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xff3E4BFF), Color(0xff8E2EFF)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: .4),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "VS",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: size.width * .03),

              /// OPPONENTS
              Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: PlayerCard(playerName: "Search...", isMe: false),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFF176), Color(0xFFFFC107)],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Get.to(GameScreen());
                  CloudTransition.push(context, const GameScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const MyText(
                  text: "Start Match",
                  fontSize: 16,
                  borderWidth: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///------------------------------------------------------------
/// PLAYER CARD
///------------------------------------------------------------

class PlayerCard extends StatelessWidget {
  final String playerName;
  final bool isMe;

  const PlayerCard({super.key, required this.playerName, this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xff39C5FF), width: 3),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff3949AB), Color(0xff171D4E)],
                ),
              ),
              child: isMe
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(AppImages.p6, fit: BoxFit.cover),
                      ),
                    )
                  : Center(
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white10,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.white70,
                          size: 34,
                        ),
                      ),
                    ),
            ),
            Positioned(
              left: 5,
              top: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Text("🇮🇳", style: TextStyle(fontSize: 25)),
              ),
            ),
            if (isMe)
              Positioned(
                bottom: -14,
                left: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff19244A),
                    border: Border.all(
                      color: const Color(0xff43D8FF),
                      width: 3,
                    ),
                  ),
                  child: const Icon(Icons.star, color: Colors.cyanAccent),
                ),
              ),
          ],
        ),
        const SizedBox(height: 28),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 41,
          decoration: BoxDecoration(
            color: const Color(0xff1A214B),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: MyText(
            text: playerName,
            borderColor: Colors.transparent,
            borderWidth: 1,
            fontSize: 22,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}

///------------------------------------------------------------
/// EMPTY CARD
///------------------------------------------------------------

class EmptyPlayerCard extends StatelessWidget {
  const EmptyPlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xff46C9FF), width: 3),
            gradient: const LinearGradient(
              colors: [Color(0xff222D74), Color(0xff11193F)],
            ),
          ),
          child: Center(
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10,
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white70,
                size: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 41,
          decoration: BoxDecoration(
            color: const Color(0xff1A214B),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: MyText(
            text: "Search...",
            borderColor: Colors.transparent,
            borderWidth: 1,
            fontSize: 22,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
