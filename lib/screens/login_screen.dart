import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';
import 'package:project/jobizz/presentation/screens/forgot_password_screen.dart';
import 'package:project/jobizz/presentation/screens/job_type_screen.dart';
import 'package:project/jobizz/presentation/screens/register_screen.dart';
import 'package:project/jobizz/presentation/widgets/text_form_text_component.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(IconBroken.Arrow___Left_2)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  AppString.welcomeBack,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  AppString.letsLoginApplyToJobs,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 40),
                textForm(
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                  label: AppString.email,
                  prefixIcon: IconBroken.Message,
                ),
                const SizedBox(height: 16),
                textForm(
                  inputType: TextInputType.visiblePassword,
                  controller: passwordController,
                  label: AppString.password,
                  prefixIcon: IconBroken.Password,
                  suffixIcon: IconBroken.Show,
                ),
                const SizedBox(height: 26),
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
                      AppString.login,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppString.forgotPassword,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.lightGreyBlue,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 30),
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.haveNotAnAccount,
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
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        AppString.register,
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
