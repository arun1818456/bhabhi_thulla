import '../../constant/export_file.dart';

class VsContainer extends StatefulWidget {
  final bool isAnimate;

  const VsContainer({super.key, this.isAnimate = false});

  @override
  State<VsContainer> createState() => _VsContainerState();
}

class _VsContainerState extends State<VsContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isAnimate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant VsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimate != oldWidget.isAnimate) {
      if (widget.isAnimate) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 1.0; // Normal size
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xff3E4BFF), Color(0xff8E2EFF)],
        ),
        boxShadow: [
          BoxShadow(color: Colors.blue.withValues(alpha: .4), blurRadius: 25),
        ],
      ),
      child: Center(
        child: ScaleTransition(
          scale: widget.isAnimate
              ? _scaleAnimation
              : const AlwaysStoppedAnimation(1.0),
          child: const Text(
            "VS",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
