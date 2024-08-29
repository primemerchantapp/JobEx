import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/jobapplication_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color.dart';
import '../../widgets/ApplicationStatusCard.dart';
import '../../widgets/AppBarWidget.dart';
import '../../widgets/TitleText.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);
  static const routeName = '/jobs';

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    final jobApplicationsProvider =
        Provider.of<JobApplications>(context, listen: false);

    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Column(
          children: [
            _title(),
            FutureBuilder(
              future: jobApplicationsProvider.fetchApplicationsForUser(userId),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('An error occurred. Please try again later.'));
                }

                if (jobApplicationsProvider.applications.isEmpty) {
                  return Center(child: Text('No applications found.'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: jobApplicationsProvider.applications.length,
                    itemBuilder: (ctx, index) {
                      final application =
                          jobApplicationsProvider.applications[index];
                      return ApplicationStatusCard(application: application);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: 'Jobs \nApplications',
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
