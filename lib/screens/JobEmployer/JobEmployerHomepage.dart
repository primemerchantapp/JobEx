import 'package:flutter/material.dart';
import 'package:jobizz/screens/JobEmployer/JobPostScreen.dart';
import 'package:jobizz/screens/JobEmployer/JobPostingsPage.dart';
import '../../components/button.dart';
import '../../theme/app_theme.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/HomeAppBarWidget.dart';
import '../../widgets/TitleText.dart';

class JobEmployerHomepage extends StatelessWidget {
  const JobEmployerHomepage({super.key});

  static const routeName = '/employer-home';

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
            children: [
              HomeAppBarWidget(),
              _title(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        label: 'POST JOB',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(JobPostScreen.routeName);
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        label: 'MANAGE APPLICATIONS',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(EmployerJobsScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: 'Jobs \nManagement',
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
