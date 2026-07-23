import '../../constant/export_file.dart';

Widget headerChip(String icon, String value, Color iconColor) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.centerLeft,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.only(left: 30, right: 5),
        decoration: BoxDecoration(
          color: Colors.black87.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 20,
              width: 20,
              child: Icon(
                Icons.add,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                size: 15,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        child: SizedBox(height: 30, width: 35, child: Image.asset(icon)),
      ),
    ],
  );
}