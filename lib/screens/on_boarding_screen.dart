import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/utils/boarding_model.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';
import 'package:project/core/utils/theme/app_string/app_string.dart';
import 'package:project/jobizz/presentation/screens/register_screen.dart';
import 'package:project/jobizz/presentation/widgets/boarding_items.dart';
import 'package:project/jobizz/presentation/widgets/text_form_text_component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    bool isLast = false;
    return Scaffold(
      body: Column(
        children: [
          SvgPicture.asset('assets/images/circle.svg'),
          SizedBox(
            width: double.infinity,
            height: 500,
            child: PageView.builder(
              onPageChanged: (value) {},
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  OnBoardingItems(boardingModel: boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: boarding.length,
            effect: const ExpandingDotsEffect(
                dotWidth: 12.0,
                dotHeight: 12.0,
                spacing: 5.0,
                expansionFactor: 3.0,
                dotColor: AppColors.silver,
                activeDotColor: AppColors.darkGreyBlue),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppString.skip,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.lightGreyBlue,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppString.next,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
