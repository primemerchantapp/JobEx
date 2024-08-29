import 'package:flutter/material.dart';
import '../providers/jobs_provider.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic padding based on screen width
    double paddingValue = MediaQuery.of(context).size.width * 0.05;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(paddingValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(job.title),
            SizedBox(height: 8),
            Text(job.location),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplicantsListPage(jobId: job.id),
                  ),
                );
              },
              child: Text('View Applications'),
            ),
          ],
        ),
      ),
    );
  }
}
