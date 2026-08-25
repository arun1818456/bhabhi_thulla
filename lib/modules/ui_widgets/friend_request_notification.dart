import 'package:bhabhi_thulla/models/pending_req_model.dart';

import '../../constant/export_file.dart';

class FriendRequestNotification extends StatelessWidget {
  final PendingRequestModel data;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onClose;

  const FriendRequestNotification({
    super.key,
    required this.data,
    required this.onAccept,
    required this.onReject,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      margin: const EdgeInsets.symmetric(horizontal: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF9B4D00), Color(0xFF612B00), Color(0xFF3B1A00)],
        ),
        border: Border.all(color: const Color(0xFFFFD45C), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.55),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: const Color(0xFFFFB300).withOpacity(.25),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // =====================================================
            // BACKGROUND GLOW
            // =====================================================
            Positioned(
              left: -35,
              top: -45,
              child: _glowCircle(size: 100, opacity: .10),
            ),

            Positioned(
              right: -35,
              bottom: -55,
              child: _glowCircle(size: 110, opacity: .06),
            ),

            // =====================================================
            // DECORATIVE STARS
            // =====================================================
            const Positioned(
              left: 12,
              top: 10,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFFFC928),
                size: 15,
              ),
            ),

            const Positioned(
              left: 30,
              bottom: 7,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFFFB91F),
                size: 9,
              ),
            ),

            const Positioned(
              right: 13,
              top: 9,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFFFC928),
                size: 14,
              ),
            ),

            // =====================================================
            // MAIN CONTENT
            // =====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // =================================================
                  // AVATAR
                  // =================================================
                  _buildAvatar(),

                  const SizedBox(width: 10),

                  // =================================================
                  // PLAYER INFO
                  // =================================================
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Row(
                          children: [
                            const Icon(
                              Icons.people_alt_rounded,
                              color: Color(0xFFFFD84F),
                              size: 16,
                            ),

                            const SizedBox(width: 5),

                            const Text(
                              "FRIEND REQUEST",
                              style: TextStyle(
                                color: Color(0xFFFFD84F),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: .4,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 2),

                        // Player Name
                        Text(
                          data.senderId?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 1),

                        const Text(
                          "wants to be your friend",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFFFFD9A0),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 7),

                  // =================================================
                  // ACTION BUTTONS
                  // =================================================
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAcceptButton(),

                      const SizedBox(height: 4),

                      _buildRejectButton(),
                    ],
                  ),

                  const SizedBox(width: 6),

                  // =================================================
                  // CLOSE BUTTON
                  // =================================================
                  _buildCloseButton(),
                ],
              ),
            ),

            // =====================================================
            // TOP GOLD HIGHLIGHT
            // =====================================================
            Positioned(
              left: 25,
              right: 25,
              top: 0,
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Color(0xFFFFF0A5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // =====================================================
            // BOTTOM GOLD LINE
            // =====================================================
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Color(0xFFFFC83D),
                      Colors.transparent,
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

  // =============================================================
  // AVATAR
  // =============================================================

  Widget _buildAvatar() {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Outer Frame
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF09A),
                  Color(0xFFFFB91F),
                  Color(0xFFB76600),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.40),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFFFB51B),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  AppImages.imageMap[data.senderId?.avatar] ?? AppImages.p1,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    );
                  },
                ),
              ),
            ),
          ),

          // =======================================================
          // LEVEL BADGE
          // =======================================================
          Positioned(
            left: -3,
            bottom: -1,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFB34DFF), Color(0xFF5C1DAD)],
                ),
                border: Border.all(color: const Color(0xFFFFD85A), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.40),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  data.senderId?.level.toString() ?? "1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // ACCEPT BUTTON
  // =============================================================

  Widget _buildAcceptButton() {
    return GestureDetector(
      onTap: onAccept,
      child: Container(
        width: 88,
        height: 31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8BEA3C), Color(0xFF36A900)],
          ),
          border: Border.all(color: const Color(0xFFFFF7A6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.30),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_rounded, color: Colors.white, size: 17),
            SizedBox(width: 4),
            Text(
              "ACCEPT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // REJECT BUTTON
  // =============================================================

  Widget _buildRejectButton() {
    return GestureDetector(
      onTap: onReject,
      child: Container(
        width: 88,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF5A4E), Color(0xFFC5251C)],
          ),
          border: Border.all(color: const Color(0xFFFFB0A8), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close_rounded, color: Colors.white, size: 15),
            SizedBox(width: 3),
            Text(
              "REJECT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // CLOSE BUTTON
  // =============================================================

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7A3900), Color(0xFF3D1900)],
          ),
          border: Border.all(color: const Color(0xFFFFD05A), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.40),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.close_rounded,
          color: Color(0xFFFFD76A),
          size: 19,
        ),
      ),
    );
  }

  // =============================================================
  // GLOW
  // =============================================================

  Widget _glowCircle({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFC13B).withOpacity(opacity),
      ),
    );
  }
}
