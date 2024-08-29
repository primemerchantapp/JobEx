import 'package:flutter/material.dart';
import 'package:jobizz/widgets/AppBarWidget.dart';
import 'package:provider/provider.dart';
import '../../providers/jobs_provider.dart';
import '../../providers/auth_provider.dart';
import '../JobEmployer/JobApplicantListScreen.dart';

class EmployerJobsScreen extends StatefulWidget {
  static const routeName = '/employer-jobs';

  @override
  _EmployerJobsScreenState createState() => _EmployerJobsScreenState();
}

class _EmployerJobsScreenState extends State<EmployerJobsScreen> {
  late Future<void> _jobsFuture;

  @override
  void initState() {
    super.initState();
    _jobsFuture = _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    final auth = Provider.of<Auth>(context, listen: false);
    final jobsProvider = Provider.of<Jobs>(context, listen: false);
    await jobsProvider.fetchJobsByEmployer(auth.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: RefreshIndicator(
        onRefresh: () => _fetchJobs(),
        child: FutureBuilder(
          future: _jobsFuture,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error fetching jobs: ${snapshot.error}'));
            } else {
              return Consumer<Jobs>(
                builder: (ctx, jobsData, child) {
                  final jobs = jobsData.jobs;
                  return jobs.isEmpty
                      ? Center(child: Text('No jobs posted yet.'))
                      : ListView.builder(
                          itemCount: jobs.length,
                          itemBuilder: (ctx, index) {
                            final job = jobs[index];
                            return Dismissible(
                              key: ValueKey(job.id),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                child: Icon(Icons.delete,
                                    color: Colors.white, size: 40),
                              ),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) {
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Are you sure?'),
                                    content:
                                        Text('Do you want to remove this job?'),
                                    actions: <Widget>[
                                      TextButton(
                                          child: Text('No'),
                                          onPressed: () =>
                                              Navigator.of(ctx).pop(false)),
                                      TextButton(
                                          child: Text('Yes'),
                                          onPressed: () =>
                                              Navigator.of(ctx).pop(true)),
                                    ],
                                  ),
                                );
                              },
                              onDismissed: (direction) async {
                                try {
                                  await jobsData.deleteJob(job.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Job deleted successfully')),
                                  );
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to delete job: $error')),
                                  );
                                }
                              },
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                child: ListTile(
                                  title: Text(job.title),
                                  subtitle: Text(job.location),
                                  trailing: Text(
                                      '\$${job.salary.toStringAsFixed(2)}'),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      ApplicantsListScreen.routeName,
                                      arguments: job.id,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
