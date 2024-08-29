import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RichTextField extends StatelessWidget {
  final String title;
  final String description;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const RichTextField({
    Key? key,
    required this.title,
    required this.description,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTheme.titleStyle,
            children: [
              TextSpan(
                text: '$title\n',
                style: AppTheme.h3Style,
              ),
              TextSpan(
                text: description,
                style: AppTheme.subTitleStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: 5,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter $title here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
