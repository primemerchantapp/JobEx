import 'package:flutter/material.dart';
import '../providers/jobapplication_provider.dart';

class ApplicationStatusCard extends StatefulWidget {
  final JobApplication application;

  const ApplicationStatusCard({Key? key, required this.application})
      : super(key: key);

  @override
  State<ApplicationStatusCard> createState() => _ApplicationStatusCardState();
}

class _ApplicationStatusCardState extends State<ApplicationStatusCard> {
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
              'Applied for Job ID: ${widget.application.jobId}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8),
            Text('Status: ${widget.application.status}'),
            Text('Date Applied: ${_formatDate(widget.application.timestamp)}'),
            SizedBox(height: 8),
            _buildStatusChip(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color chipColor;
    String statusText;

    switch (widget.application.status.toLowerCase()) {
      case 'pending':
        chipColor = Colors.orange;
        statusText = 'Awaiting Response';
        break;
      case 'accepted':
        chipColor = Colors.green;
        statusText = 'Accepted';
        break;
      case 'rejected':
        chipColor = Colors.red;
        statusText = 'Rejected';
        break;
      default:
        chipColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Chip(
      label: Text(statusText),
      backgroundColor: chipColor,
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
