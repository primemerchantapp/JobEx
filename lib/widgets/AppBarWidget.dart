import 'package:flutter/material.dart';
import 'package:jobizz/widgets/SearchWidget.dart';
import '../theme/app_theme.dart';
import '../theme/color.dart';
import 'DrawerWidget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: LightColor.background,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xfff8f8f8),
                blurRadius: 10,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(13),
          child: _icon(context, Icons.arrow_back_ios, color: Colors.black54),
        ),
      ),
      centerTitle: true,
      title: Image.asset(
        "assets/images/job.png",
        width: 100,
        height: 60,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _icon(context, Icons.notifications, color: Colors.black54),
        ),
      ],
    );
  }

  /// Creates an icon with a circular background and shadow.
  Widget _icon(BuildContext context, IconData icon,
      {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: Theme.of(context).colorScheme.background,
        boxShadow: AppTheme.shadow,
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
