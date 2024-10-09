import 'package:flutter/material.dart';
import 'package:project/core/utils/fonts/icon_broken.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';
import 'package:project/jobizz/presentation/screens/confirmation_screen.dart';
import 'package:project/jobizz/presentation/widgets/text_form_text_component.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var passwordController = TextEditingController();
    var newPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(IconBroken.Arrow___Left_2)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightGreyBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
                const SizedBox(height: 20),
                Text(
                  AppString.resetPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                ),
                const SizedBox(height: 50),
                Text(
                  textAlign: TextAlign.center,
                  AppString
                      .enterYourNewPasswordAndConfirmTheNewPasswordToResetPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 80),
                textForm(
                  inputType: TextInputType.visiblePassword,
                  controller: passwordController,
                  label: AppString.newPassword,
                  prefixIcon: IconBroken.Password,
                  suffixIcon: IconBroken.Show,
                  suffixPressed: () {},
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppString.mustNotBeEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                textForm(
                  inputType: TextInputType.visiblePassword,
                  controller: newPasswordController,
                  label: AppString.confirmPassword,
                  prefixIcon: IconBroken.Password,
                  suffixIcon: IconBroken.Show,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppString.mustNotBeEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 55),
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
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfirmationScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      AppString.resetPassword,
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
        ),
      ),
    );
  }
}
