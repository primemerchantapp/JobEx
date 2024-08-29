import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/HomeAppBarWidget.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/CategoriesGridCard.dart';
import '../../widgets/TitleText.dart';

class JobSeekerHomepage extends StatefulWidget {
  const JobSeekerHomepage({Key? key}) : super(key: key);
  static const routeName = '/job-seeker-home';

  @override
  State<JobSeekerHomepage> createState() => _JobSeekerHomepageState();
}

class _JobSeekerHomepageState extends State<JobSeekerHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          height: AppTheme.fullHeight(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfffbfbfb),
                Color(0xfff7f7f7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              HomeAppBarWidget(),
              _title(),
              Expanded(
                child: CategoriesGridCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates the title section of the homepage.
  Widget _title() {
    // Calculate dynamic padding based on screen width
    double paddingValue = MediaQuery.of(context).size.width * 0.05;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: paddingValue, vertical: paddingValue),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: 'Job \nCategories',
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
