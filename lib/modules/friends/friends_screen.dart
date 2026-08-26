import '../../constant/export_file.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      init: FriendsController(),
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          // height: Get.height * 0.8,
          width: Get.width * 0.95,
          child: Row(
            children: [
              leftSideWidget(controller),
              const SizedBox(width: 15),
              rightSideWidget(controller),
            ],
          ),
        );
      },
    );
  }

  Widget leftSideWidget(FriendsController controller) {
    return Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.pendingRequests.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                child: Row(
                  children: [
                    const MyText(text: "Friend Requests", fontSize: 16),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MyText(
                        text: controller.pendingRequests.length.toString(),
                        fontSize: 12,
                        borderColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 95,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.pendingRequests.length,
                  itemBuilder: (context, index) {
                    final request = controller.pendingRequests[index];
                    return _requestCard(controller, request, index);
                  },
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 8),
                child: MyText(text: "My Friends", fontSize: 18),
              ),
            ],

            Expanded(
              child: controller.myFriends.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      itemCount: controller.myFriends.length,
                      itemBuilder: (context, index) {
                        final friend = controller.myFriends[index];
                        return AnimatorWidget(
                          effect: AnimationEffect.scale,
                          delay: Duration(milliseconds: 50 * index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade700.withValues(
                                alpha: 0.85,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.amber, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Avatar
                                Container(
                                  width: 55,
                                  height: 55,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AppImages.profileBgCard,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  child: Image.asset(
                                    AppImages.imageMap[friend.avatar] ??
                                        AppImages.p1,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 15),

                                // Friend Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: friend.name ?? "",
                                        fontSize: 18,
                                      ),
                                      MyText(
                                        text:
                                            "LVL: ${friend.level ?? "1"} | PID: ${friend.pid}",
                                        fontSize: 12,
                                        color: Colors.amberAccent,
                                        borderColor: Colors.transparent,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: (friend.isOnline ?? false)
                                                  ? Colors.green
                                                  : Colors.grey,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          MyText(
                                            text: (friend.isOnline ?? false)
                                                ? "Online"
                                                : "Offline",
                                            fontSize: 12,
                                            color: (friend.isOnline ?? false)
                                                ? Colors.greenAccent
                                                : Colors.grey,
                                            borderColor: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Actions
                                IconButton(
                                  onPressed: () =>
                                      controller.removeFriend(index),
                                  icon: const Icon(
                                    Icons.person_remove,
                                    color: Colors.redAccent,
                                    size: 22,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person_pin_outlined, size: 50),
                            const SizedBox(height: 10),
                            const MyText(
                              text: "No Friends found",
                              fontSize: 25,
                            ),
                            const Text(
                              "Search for a Player ID to Add a Friend",
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestCard(
    FriendsController controller,
    PendingRequestModel request,
    int index,
  ) {
    return Container(
      width: 245,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orangeAccent, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.profileBgCard),
                fit: BoxFit.contain,
              ),
            ),
            child: Image.asset(
              AppImages.imageMap[request.senderId?.avatar] ?? AppImages.p1,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(text: request.senderId?.name ?? "", fontSize: 16),
                  MyText(
                    text: "PID: ${request.senderId!.pid}",
                    fontSize: 11,
                    color: Colors.amberAccent,
                    borderColor: Colors.transparent,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      _requestAction(
                        icon: Icons.check,
                        color: Colors.green,
                        tooltip: "Accept request",
                        onPressed: () => controller.acceptRequest(
                          receiverId: controller.getUserData().id!,
                          requestId: request.sId!,
                        ),
                      ),
                      const SizedBox(width: 7),
                      _requestAction(
                        icon: Icons.close,
                        color: Colors.redAccent,
                        tooltip: "Decline request",
                        onPressed: () => controller.rejectRequest(
                          receiverId: controller.getUserData().id!,
                          requestId: request.sId!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestAction({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 60,
          height: 27,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget rightSideWidget(FriendsController controller) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          return Container(
            height: Get.height * 0.72,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.amber, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                const FittedBox(
                  child: MyText(
                    text: "Add Friend",
                    fontSize: 22,
                    borderWidth: 3,
                  ),
                ),
                SizedBox(height: maxHeight * 0.02),

                // Search PID Field
                TextFormField(
                  controller: controller.searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter PID",
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: Colors.brown.shade900.withValues(alpha: 0.8),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    suffixIcon: InkWell(
                      onTap: controller.searchPlayer,
                      child: const Icon(
                        Icons.search,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.amber,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.amber,
                        width: 2.5,
                      ),
                    ),
                  ),
                  onSaved: (_) => controller.searchPlayer(),
                ),

                const SizedBox(height: 10),

                // Search Result Area (Responsive & Specific Layout)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: controller.searchedPlayer == null
                        ? Container(
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: MyText(
                                text: "Find players by ID",
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.3),
                                borderColor: Colors.transparent,
                              ),
                            ),
                          )
                        : AnimatorWidget(
                            effect: AnimationEffect.scale,
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                // --- Avatar and Details in a Row ---
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 70,
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                AppImages.profileBgCard,
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: Image.asset(
                                            AppImages.imageMap[controller
                                                    .searchedPlayer!
                                                    .avatar] ??
                                                AppImages.p1,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        if (controller.searchedPlayer!.flag !=
                                            null)
                                          Positioned(
                                            top: 5,
                                            child: Text(
                                              flags[controller
                                                  .searchedPlayer!
                                                  .flag]!,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: MyText(
                                              text:
                                                  controller
                                                      .searchedPlayer!
                                                      .name ??
                                                  "",
                                              fontSize: 18,
                                            ),
                                          ),
                                          FittedBox(
                                            child: MyText(
                                              text:
                                                  "PID: ${controller.searchedPlayer!.pid}",
                                              fontSize: 14,
                                              color: Colors.amberAccent,
                                              borderColor: Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // --- Add Friend Button below in Column ---
                                ElevatedButton(
                                  onPressed: controller.sendRequest,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 12,
                                    ),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: const MyText(
                                    text: "Add Friend",
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
