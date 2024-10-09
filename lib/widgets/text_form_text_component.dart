import 'package:flutter/material.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';

Widget textForm({
  required TextInputType inputType,
  required TextEditingController controller,
  FormFieldValidator<String>? validate,
  Function? onSubmit,
  String? label,
  bool isPassword = false,
  int? maxLength,
  IconData? prefixIcon,
  double? height,
  double? width,
  double radius = 10,
  IconData? suffixIcon,
  Function? suffixPressed,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        validator: validate,
        obscureText: isPassword,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:
                const BorderSide(color: AppColors.lightGrey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:
                const BorderSide(color: AppColors.lightGrey, width: 1.0),
          ),
          fillColor: AppColors.lightGrey,
          labelText: label,
          prefixIcon: Icon(
            prefixIcon,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffixIcon, color: AppColors.lightGrey),
                )
              : null,
        ),
        onFieldSubmitted: (value) {
          onSubmit!(value);
        },
      ),
    );
