import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/utils/fonts/icon_broken.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';
import 'package:project/jobizz/presentation/screens/login_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

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
            const SizedBox(height: 70),
            Center(
              child: SvgPicture.asset(
                'assets/images/confirmation.svg',
                width: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppString.confirmation,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            const SizedBox(height: 50),
            Text(
              textAlign: TextAlign.center,
              AppString
                  .yourPasswordHasBeenChangedPleaseLoginWithYourNewPassword,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 50),
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
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  AppString.login,
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
