import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../theme/color.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),
            _createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the home screen
                  // Navigator.pushReplacementNamed(context, '/home');
                },
                context: context),
            _createDrawerItem(
                icon: FontAwesomeIcons.user,
                text: 'Sign Out',
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Implement sign-out logic here
                },
                context: context),
            _createDrawerItem(
                icon: Icons.favorite_border,
                text: 'Wish List',
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the wish list screen
                  // Navigator.pushReplacementNamed(context, '/wishlist');
                },
                context: context),
            _createDrawerItem(
                icon: Icons.call,
                text: 'Contact Us',
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the contact us screen
                  // Navigator.pushReplacementNamed(context, '/contact');
                },
                context: context),
          ],
        ),
      ),
    );
  }

  /// Creates the header of the drawer.
  Widget _createDrawerHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Image.asset(
                'assets/images/job.png',
                width: 130,
                height: 130,
              ),
            ),
          ),
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Welcome 'TARIKUL'",
              style: AppTheme.h5Style.copyWith(
                color: LightColor.titleTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Creates a drawer item with an icon and text.
  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap,
      required BuildContext context}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: LightColor.iconColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              text,
              style: AppTheme.subTitleStyle.copyWith(
                color: LightColor.subTitleTextColor,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
