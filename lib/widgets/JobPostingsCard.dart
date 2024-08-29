import 'package:flutter/material.dart';
import 'package:jobizz/providers/jobs_provider.dart';

class JobCard extends StatefulWidget {
  final Job job;
  final VoidCallback onViewApplications;

  const JobCard({
    Key? key,
    required this.job,
    required this.onViewApplications,
  }) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: widget.onViewApplications,
            child: Text('View Applications'),
          ),
        ],
      ),
    );
  }
}
