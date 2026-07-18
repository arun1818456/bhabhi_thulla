import 'package:flutter/services.dart';

import '../constant/colors.dart';
import '../constant/export_file.dart';

class MyTextFieldForm extends StatefulWidget {
  final TextCapitalization? textCapitalization;
  final String hintText;
  final bool filled;
  final Color filledColor;
  final TextEditingController? tfController;
  final Function? validator2;
  final IconButton? postfix;
  final List<TextInputFormatter>? filterPattern;
  final TextInputType? keyboardType;
  final bool isPass;
  final String? headerText;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;
  final IconData? kImage;
  final double? topPadding;
  final double? containerHeight;
  final double? bottomPadding;
  final double? horizontalPadding;
  final String? initialValue;
  final Function? onChange;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final Function? onFieldSubmitted;
  const MyTextFieldForm({
    super.key,
    this.textCapitalization,
    required this.hintText,
    this.tfController,
    this.focusNode,
    this.headerText,
    this.postfix,
    this.onTap,
    this.validator2,
    this.keyboardType,
    this.isPass = false,
    this.minLines,
    this.maxLines,
    this.containerHeight,
    this.kImage,
    this.initialValue,
    this.readOnly,
    this.onChange,
    this.filterPattern,
    this.onFieldSubmitted,
    this.topPadding,
    this.bottomPadding,
    this.horizontalPadding,
    this.filled = false,
    this.filledColor = AppColors.whiteColor,
  });

  @override
  State<MyTextFieldForm> createState() => _MyTextFieldFormState();
}

class _MyTextFieldFormState extends State<MyTextFieldForm> {
  bool showPass = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 15),
      height: widget.containerHeight ?? 55,
      decoration: BoxDecoration(
          color: widget.filled ? widget.filledColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColors.fadeGreyColor)),
      margin: EdgeInsets.only(
          top: widget.topPadding ?? 0,
          bottom: widget.bottomPadding ?? 0,
          left: widget.horizontalPadding ?? 0,
          right: widget.horizontalPadding ?? 0),
      // padding: EdgeInsets.only(left: 0,),
      child: TextFormField(
        focusNode: widget.focusNode,
        textInputAction: TextInputAction.done,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        cursorColor: Colors.black,
        cursorHeight: 18,
        cursorWidth: 1.5,
        onTap: widget.onTap,
        controller: widget.tfController,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly == null ? false : widget.readOnly!,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.filterPattern,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPass == true ? showPass : false,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        validator: (value) {
          if (widget.validator2 != null) {
            return widget.validator2!(value);
          }
          return null;
        },
        onChanged: (string) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          if (widget.onChange != null) {
            widget.onChange!(string);
          }
        },
        onFieldSubmitted: (string) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          if (widget.onFieldSubmitted != null) {
            widget.onFieldSubmitted!(string);
          }
        },
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          prefixIcon: widget.kImage != null
              ? Container(
                  // height: 16,
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                  // child: Image.asset(widget.kImage!,)
                  child: Icon(widget.kImage),
                )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(18, 15, 14, 12),
          hintText: widget.hintText,
          // hintStyle: w_500.copyWith(color: AppColors.greyColor),
          suffixIcon: widget.isPass == true
              ? IconButton(
                  // padding:const EdgeInsets.symmetric(vertical: 18.5,horizontal: 17),
                  onPressed: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  icon: !showPass
                      ? Image.asset(
                          "assets/icons/open_eye.png",
                          height: 25,
                          width: 25,
                        )
                      : Image.asset(
                          "assets/icons/close_eye.png",
                          height: 25,
                          width: 25,
                        ),
                  color: AppColors.blackColor,
                )
              : widget.postfix,
        ),
      ),
    );
  }
}
