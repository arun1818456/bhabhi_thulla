import 'dart:math' as math;

import '../../constant/export_file.dart';

class SoloRoom extends StatelessWidget {
  const SoloRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GameRoom> rooms = [
      GameRoom(prize: 160, entryFee: 120),
      GameRoom(prize: 380, entryFee: 300),
      GameRoom(prize: 760, entryFee: 600),
      GameRoom(prize: 1500, entryFee: 1200),
      GameRoom(prize: 3200, entryFee: 2500),
      GameRoom(prize: 6500, entryFee: 5200),
    ];
    return SizedBox(
      height: Get.height / 2 + 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return FlipRoomCard(room: room);
        },
      ),
    );
  }
}

class GameRoom {
  final int prize;
  final int entryFee;

  GameRoom({required this.prize, required this.entryFee});
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
      builder: (_, __) {
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
                    MyText(text: "1st", fontSize: 18,borderColor: Colors.orangeAccent,borderWidth: 1.5,),
                    SizedBox(width: 5,),
                    Image.asset(AppImages.coin,width: 20,height: 20,),
                    SizedBox(width: 5,),
                    MyText(text: "${widget.room.prize}", fontSize: 18,borderColor: Colors.orangeAccent,borderWidth: 1.5,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(text: "2nd", fontSize: 18,borderColor: Colors.orangeAccent,borderWidth: 1.5,),
                    SizedBox(width: 5,),
                    Image.asset(AppImages.coin,width: 20,height: 20,),
                    SizedBox(width: 5,),
                    MyText(text: "${widget.room.prize}", fontSize: 18,borderColor: Colors.orangeAccent,borderWidth: 1.5,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(text: "3rd", fontSize: 18,borderColor: Colors.orangeAccent,borderWidth: 1.5,),
                    SizedBox(width: 5,),
                    Image.asset(AppImages.coin,width: 20,height: 20,),
                    SizedBox(width: 5,),
                    MyText(text: "${widget.room.prize}", fontSize: 18,borderColor: Colors.orangeAccent,borderWidth: 1.5,),
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
