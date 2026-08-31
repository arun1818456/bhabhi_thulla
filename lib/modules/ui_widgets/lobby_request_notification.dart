import '../../constant/export_file.dart';

class LobbyRequestNotification extends StatelessWidget {
  final String name;
  final String avatar;
  final String level;

  final VoidCallback onJoin;
  final VoidCallback onDecline;
  final VoidCallback onClose;

  const LobbyRequestNotification({
    super.key,
    required this.name,
    required this.avatar,
    required this.level,
    required this.onJoin,
    required this.onDecline,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      margin: const EdgeInsets.symmetric(horizontal: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF9B4D00), Color(0xFF612B00), Color(0xFF351600)],
        ),
        border: Border.all(color: const Color(0xFFFFD45C), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .60),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
          BoxShadow(
            color: const Color(0xFFFFB300).withValues(alpha: .25),
            blurRadius: 18,
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
              left: -40,
              top: -50,
              child: _glowCircle(size: 120, opacity: .12),
            ),

            Positioned(
              right: -40,
              bottom: -60,
              child: _glowCircle(size: 120, opacity: .07),
            ),

            // =====================================================
            // DECORATIVE STARS
            // =====================================================
            const Positioned(
              left: 12,
              top: 10,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFFFD447),
                size: 14,
              ),
            ),

            const Positioned(
              left: 32,
              bottom: 8,
              child: Icon(
                Icons.auto_awesome,
                color: Color(0xFFFFB91F),
                size: 9,
              ),
            ),

            const Positioned(
              right: 15,
              top: 8,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFFFD447),
                size: 13,
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
                        // GAME INVITE TITLE
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFFE77A),
                                    Color(0xFFFFA900),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFFB300,
                                    ).withValues(alpha: .35),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.sports_esports_rounded,
                                color: Color(0xFF5A2600),
                                size: 12,
                              ),
                            ),

                            const SizedBox(width: 6),

                            const Text(
                              "GAME INVITE",
                              style: TextStyle(
                                color: Color(0xFFFFD84F),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: .7,
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

                        // PLAYER NAME
                        Text(
                          name,
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

                        // REQUEST TEXT
                        const Text(
                          "sent you a game request",
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

                  const SizedBox(width: 8),

                  // =================================================
                  // ACTION BUTTONS
                  // =================================================
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildJoinButton(),

                      const SizedBox(height: 4),

                      _buildDeclineButton(),
                    ],
                  ),

                  const SizedBox(width: 6),

                  // =================================================
                  // CLOSE
                  // =================================================
                  _buildCloseButton(),
                ],
              ),
            ),

            // =====================================================
            // TOP HIGHLIGHT
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
                  color: Colors.black.withValues(alpha: .45),
                  blurRadius: 7,
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
                  avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 30,
                    );
                  },
                ),
              ),
            ),
          ),

          // LEVEL BADGE
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
                    color: Colors.black.withValues(alpha: .45),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  level,
                  style: const TextStyle(
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
  // JOIN GAME
  // =============================================================

  Widget _buildJoinButton() {
    return GestureDetector(
      onTap: onJoin,
      child: Container(
        width: 92,
        height: 31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFE35A), Color(0xFFFFA500), Color(0xFFD66A00)],
          ),
          border: Border.all(color: const Color(0xFFFFF5A8), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFA800).withValues(alpha: .30),
              blurRadius: 7,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: .30),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
            SizedBox(width: 3),
            Text(
              "JOIN GAME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: .2,
                shadows: [
                  Shadow(
                    color: Colors.black87,
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
  // DECLINE
  // =============================================================

  Widget _buildDeclineButton() {
    return GestureDetector(
      onTap: onDecline,
      child: Container(
        width: 92,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF665A), Color(0xFFC5251C)],
          ),
          border: Border.all(color: const Color(0xFFFFB0A8), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .25),
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
              "DECLINE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: .2,
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
  // CLOSE
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
              color: Colors.black.withValues(alpha: .40),
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
        color: const Color(0xFFFFC13B).withValues(alpha: opacity),
      ),
    );
  }
}
