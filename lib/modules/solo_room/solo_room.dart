import '../../constant/export_file.dart';

class SoloRoom extends StatelessWidget {
  const SoloRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SoloRoomController(),
      builder: (controller) => controller.prizeSelected != null
          ? matchCenterRow(context, controller)
          : SizedBox(
              height: Get.height / 2 + 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
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

Widget matchCenterRow(BuildContext context, SoloRoomController controller) {
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
            playerCard(
              controller.userData.name ?? "--",
              true,
              controller.isMatchFounding,
              controller,
              0,
            ),

            SizedBox(width: size.width * .03),

            /// VS
            VsContainer(isAnimate: controller.isMatchFounding),

            SizedBox(width: size.width * .03),

            /// OPPONENTS
            Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: playerCard(
                    "Search",
                    false,
                    controller.isMatchFounding,
                    controller,
                    controller.searchCount,
                    index: index,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (!controller.isMatchFounding)
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
                  controller.onTapStartMatch();
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
          )
        else
          MyText(
            text: "Searching for players ...",
            fontSize: 20,
            color: Colors.white,
            borderColor: Colors.black,
            borderWidth: 4,
          ),
      ],
    ),
  );
}

///------------------------------------------------------------
/// PLAYER CARD
///------------------------------------------------------------

Widget playerCard(
  String playerName,
  bool isMe,
  bool isSearching,
  SoloRoomController controller,
  int searchCount, {
  index = 0,
}) {
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
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      AppImages.imageMap[controller.userData.avatar] ??
                          AppImages.p1,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : isSearching
                ? SearchingAvatar(startIndex: index * 2)
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.onTapToJoinFriend();
                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white10,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(
                          Icons.person_add_alt,
                          color: Colors.white70,
                          size: 34,
                        ),
                      ),
                    ),
                  ),
          ),
          if (isMe)
            Positioned(
              left: 5,
              top: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Text(flags["AU"]!, style: TextStyle(fontSize: 25)),
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
                  border: Border.all(color: const Color(0xff43D8FF), width: 3),
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
        child: Row(
          children: [
            MyText(
              text: playerName,
              borderColor: Colors.transparent,
              borderWidth: 1,
              fontSize: 22,
              fontWeight: FontWeight.w100,
            ),
            if (isSearching)
              MyText(
                text: ". " * searchCount,
                borderColor: Colors.transparent,
                borderWidth: 1,
                fontSize: 22,
                fontWeight: FontWeight.w100,
              ),
          ],
        ),
      ),
    ],
  );
}
