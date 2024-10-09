import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';
import 'package:project/jobizz/presentation/screens/job_type_screen.dart';
import 'package:project/jobizz/presentation/screens/login_screen.dart';
import 'package:project/jobizz/presentation/widgets/text_form_text_component.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(IconBroken.Arrow___Left_2)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightGreyBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  AppString.registration,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  AppString.letsRegisterApplyToJobs,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 36),
                textForm(
                  inputType: TextInputType.name,
                  controller: nameController,
                  label: AppString.fullName,
                  prefixIcon: IconBroken.Profile,
                ),
                const SizedBox(height: 12),
                textForm(
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                  label: AppString.email,
                  prefixIcon: IconBroken.Message,
                ),
                const SizedBox(height: 12),
                textForm(
                  inputType: TextInputType.phone,
                  controller: phoneController,
                  label: AppString.phoneNumber,
                  prefixIcon: IconBroken.Call,
                ),
                const SizedBox(height: 12),
                textForm(
                  inputType: TextInputType.visiblePassword,
                  controller: passwordController,
                  label: AppString.password,
                  prefixIcon: IconBroken.Password,
                  suffixIcon: IconBroken.Show,
                ),
                const SizedBox(height: 12),
                textForm(
                  inputType: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  label: AppString.confirmPassword,
                  prefixIcon: IconBroken.Password,
                  suffixIcon: IconBroken.Show,
                ),
                const SizedBox(height: 22),
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
                      AppString.register,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
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
                      width: 80,
                      height: 1,
                      color: AppColors.lightGrey,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/images/apple.svg',
                          width: 34,
                          height: 34,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/images/google.svg',
                          width: 34,
                          height: 34,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/images/facebook.svg',
                          width: 34,
                          height: 34,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.haveAnAccount,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.lightGrey),
                    ),
                    TextButton(
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.lightGreyBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
