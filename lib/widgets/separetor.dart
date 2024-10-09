import 'package:flutter/material.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 1,
              color: AppColors.lightGrey,
            ),
            const SizedBox(width: 10),
            Text(
              AppString.orContinueWith,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.lightGrey,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(width: 10),
            Container(
              width: 100,
              height: 1,
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
