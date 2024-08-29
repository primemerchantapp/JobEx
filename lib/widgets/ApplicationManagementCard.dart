import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../providers/jobapplication_provider.dart';

class ApplicationManagementCard extends StatefulWidget {
  final JobApplication application;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ApplicationManagementCard({
    Key? key,
    required this.application,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  State<ApplicationManagementCard> createState() =>
      _ApplicationManagementCardState();
}

class _ApplicationManagementCardState extends State<ApplicationManagementCard> {
  Future<void> _downloadAndOpenResume(BuildContext context) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloading resume...')),
      );

      // Get the download URL from Firebase Storage
      final ref = FirebaseStorage.instance.ref(widget.application.resumePath);
      final url = await ref.getDownloadURL();

      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/${widget.application.lastName}_resume.pdf';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.application.firstName} ${widget.application.lastName}',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text('Contact: ${widget.application.contactNumber}'),
            Text('Status: ${widget.application.status}'),
            SizedBox(height: 8),
            Text('Cover Letter:', style: Theme.of(context).textTheme.subtitle1),
            Text(widget.application.coverLetter),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _downloadAndOpenResume(context),
              child: Text('View Resume'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context: context,
                  onPressed: widget.application.status == 'accepted'
                      ? null
                      : widget.onAccept,
                  label: 'Accept',
                  color: Colors.green,
                ),
                _buildActionButton(
                  context: context,
                  onPressed: widget.application.status == 'rejected'
                      ? null
                      : widget.onReject,
                  label: 'Reject',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required VoidCallback? onPressed,
    required String label,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: onPressed == null ? Colors.grey : color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
