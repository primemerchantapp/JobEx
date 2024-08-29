import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/color.dart';
import '../widgets/TitleText.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
          padding: MaterialStateProperty.all(
              EdgeInsets.zero), // Remove extra padding
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              vertical: 12), // Adjust padding for button size
          width: AppTheme.fullWidth(context) *
              0.75, // Ensure the width is not stretched
          child: TitleText(
            text: label,
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
