
import '../constant/colors.dart';
import '../constant/export_file.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? border;
  final Color? color;
  final bool? loading;
  final double? width;
  final Color? textColor;
  final Function() onPressed;
  final Widget? buttonCenter;
  final double? buttonHeight;
  final double? verticalPadding;
  final double? horizontalPadding;

  const CustomButton({
    super.key,
    this.color,
    this.width,
    this.border,
    this.textColor,
    this.buttonCenter,
    this.buttonHeight,
    required this.text,
    this.verticalPadding,
    this.loading = false,
    this.horizontalPadding,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.blackColor,
      ),
      height: buttonHeight ?? 55, // Default height
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 0,
        vertical: verticalPadding ?? 0,
      ),
      width: width ?? Get.width, // Default to full width
      child: ElevatedButton(
        onPressed: loading == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.blackColor, // Text color
          backgroundColor: color ?? AppColors.blackColor, // Button background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
            side: border == true
                ? const BorderSide(
              color: AppColors.blackColor,
              width: 1,
            )
                : BorderSide.none, // No border by default
          ),
          elevation: 5, // Shadow effect
        ),
        child: loading == true
            ? const CircularProgressIndicator(
          color: AppColors.whiteColor,
        )
            : buttonCenter ??
            Text(
              text,
              style: TextStyle(
                color: textColor ?? AppColors.whiteColor, // Text color
              ),
            ),
      ),
    );
  }
}
