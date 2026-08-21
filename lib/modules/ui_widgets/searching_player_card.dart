import '../../constant/export_file.dart';

class SearchingAvatar extends StatefulWidget {
  final int startIndex;

  const SearchingAvatar({super.key, this.startIndex = 0});

  @override
  State<SearchingAvatar> createState() => _SearchingAvatarState();
}

class _SearchingAvatarState extends State<SearchingAvatar>
    with TickerProviderStateMixin {
  Timer? _timer;

  late int _currentIndex;

  final List<String> _avatars = AppImages.imageMap.values.toList();

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.startIndex % _avatars.length;

    // Different starting delay for every row
    Future.delayed(Duration(milliseconds: widget.startIndex * 150), () {
      if (!mounted) return;

      _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (!mounted) return;

        setState(() {
          _currentIndex = (_currentIndex + 1) % _avatars.length;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: Image.asset(
                _avatars[_currentIndex],
                key: ValueKey(_currentIndex),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
