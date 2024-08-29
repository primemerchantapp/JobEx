import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/jobs_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/AppBarWidget.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/TitleText.dart';
import '../../components/button.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({Key? key}) : super(key: key);
  static const routeName = '/job-detail';

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    final jobId = ModalRoute.of(context)!.settings.arguments as String;
    final job = Provider.of<Jobs>(context, listen: false).findById(jobId);

    return Scaffold(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      job.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    title: 'Salary',
                    content: "${job.salary} per ${job.rate}",
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    title: 'Location',
                    content: job.location,
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    title: 'Description',
                    content: job.description,
                  ),
                  SizedBox(height: 20),
                  _buildSection(
                    title: 'Requirements',
                    content: job.requirements,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: AppTheme.padding,
          child: CustomButton(
            label: 'APPLY FOR JOB',
            onPressed: () {
              //     Navigator.of(context).pushNamed(
              //   JobApplicationScreen.routeName,
              //   arguments: job.id,
              // );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
