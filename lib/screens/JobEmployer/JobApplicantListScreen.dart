import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/jobapplication_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color.dart';
import '../../widgets/AppBarWidget.dart';
import '../../widgets/TitleText.dart';

class ApplicantsListScreen extends StatelessWidget {
  static const routeName = '/applicants-list';

  @override
  Widget build(BuildContext context) {
    final jobId = ModalRoute.of(context)!.settings.arguments as String;
    final applicationsProvider =
        Provider.of<JobApplications>(context, listen: false);

    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Column(
          children: [
            _title(),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('jobApplications')
                    .where('jobId', isEqualTo: jobId)
                    .get(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No applicants found.'));
                  }

                  final applicants = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: applicants.length,
                    itemBuilder: (ctx, i) {
                      final applicant = applicants[i];
                      final name =
                          '${applicant['firstName']} ${applicant['lastName']}';
                      final appliedTime =
                          (applicant['timestamp'] as Timestamp).toDate();

                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/application-details', // Ensure this route is correctly set up
                            arguments:
                                applicant.id, // Pass the correct argument
                          );
                        },
                        title: Text(name),
                        subtitle: Text('Applied on: ${appliedTime.toLocal()}'),
                      );
                    },
                  );
                },
              ),
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
                text: 'Job \nApplicants',
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
