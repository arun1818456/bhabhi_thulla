

import '../constant/export_file.dart';

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
      height: Get.height/2+50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];

          return Container(
            width: 150,
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Stack(
              children: [

                // Black Background
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                // Info Button
                Positioned(
                  right: 10,
                  top: 10,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(
                      Icons.info,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Center Content
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            const Text(
                              "Prize",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              room.prize.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Entry Fee",
                        style: TextStyle(
                          color: Colors.orange.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        room.entryFee.toString(),
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GameRoom {
  final int prize;
  final int entryFee;

  GameRoom({
    required this.prize,
    required this.entryFee,
  });
}