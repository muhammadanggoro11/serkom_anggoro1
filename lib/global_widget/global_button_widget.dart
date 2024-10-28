import 'package:flutter/material.dart';
import 'package:kpukom/utils/text_styles_constant.dart';

import '../utils/color_constant.dart';

class GlobalButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;

  const GlobalButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.buttonColor = ColorsConstant.white,
    this.textColor = ColorsConstant.white,
    this.buttonHeight = 46,
    this.buttonWidth = double.infinity,
    this.buttonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Ink(
        width: buttonWidth,
        height: buttonHeight,
        padding: buttonPadding,
        decoration: BoxDecoration(
          color: buttonColor, // Gunakan warna dari parameter
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStylesConstant.nunitoButtonBold.copyWith(
              color: textColor, // Gunakan textColor dari parameter
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}