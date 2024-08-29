import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/jobapplication_provider.dart';
import '../../widgets/AppBarWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicantDetailScreen extends StatelessWidget {
  Future<void> _downloadAndOpenResume(
      BuildContext context, String resumePath, String lastName) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloading resume...')),
      );

      // Get the download URL from Firebase Storage
      final ref = FirebaseStorage.instance.ref(resumePath);
      final url = await ref.getDownloadURL();

      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${lastName}_resume.pdf';

      // Download file
      final file = File(filePath);
      await ref.writeToFile(file);

      // Hide loading indicator
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Open the file
      await OpenFile.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading resume: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final applicationId = ModalRoute.of(context)!.settings.arguments as String;
    final applicationsProvider =
        Provider.of<JobApplications>(context, listen: false);
    final application = applicationsProvider.applications
        .firstWhere((app) => app.id == applicationId);

    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${application.firstName} ${application.lastName}',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 8),
            Text('Contact: ${application.contactNumber}'),
            SizedBox(height: 16),
            Text('Cover Letter:',
                style: Theme.of(context).textTheme.titleLarge),
            Text(application.coverLetter),
            SizedBox(height: 16),
            Text('Additional Details:',
                style: Theme.of(context).textTheme.titleLarge),
            Text(application.additionalDetails),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('View Resume'),
              onPressed: () {
                _downloadAndOpenResume(
                    context, application.resumePath, application.lastName);
              },
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Accept'),
                  onPressed: () async {
                    await applicationsProvider.acceptApplication(applicationId);
                    Navigator.of(context).pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton(
                  child: Text('Reject'),
                  onPressed: () async {
                    await applicationsProvider.rejectApplication(applicationId);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
