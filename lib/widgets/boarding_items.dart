import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/utils/boarding_model.dart';
import 'package:project/core/utils/theme/app_colors/app_colors.dart';

class OnBoardingItems extends StatelessWidget {
  BoardingModel boardingModel;

  OnBoardingItems({super.key, required this.boardingModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SvgPicture.asset(boardingModel.image),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              textAlign: TextAlign.center,
              boardingModel.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Text(
              textAlign: TextAlign.center,
              boardingModel.body,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
