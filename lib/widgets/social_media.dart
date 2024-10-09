import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/images/apple.svg',
                width: 32,
                height: 32,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/images/google.svg',
                width: 32,
                height: 32,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/images/facebook.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
