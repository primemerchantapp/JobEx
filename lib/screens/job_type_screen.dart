import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/utils/fonts/icon_broken.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';

class JobTypeScreen extends StatelessWidget {
  const JobTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(IconBroken.Close_Square)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightGreyBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            ),
            const SizedBox(height: 30),
            Text(
              AppString.whatTypeOfJobYouAreLookingFor,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            const SizedBox(height: 60),
            Row(
              children: [

                const Text(AppString.designer),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.grey,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                color: AppColors.lightGreyBlue,
                borderRadius: BorderRadiusDirectional.all(
                  Radius.circular(5),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JobTypeScreen(),
                    ),
                  );
                },
                child: Text(
                  AppString.save,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
