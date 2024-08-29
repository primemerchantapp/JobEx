import 'package:flutter/material.dart';
import 'package:jobizz/providers/jobapplication_provider.dart';
import './screens/JobSeeker/JobSeekerHomepage.dart';
import './screens/JobSeeker/SubCategory.dart';
import './screens/JobSeeker/JobDetailScreen.dart';
import './screens/JobSeeker/JobApplicationScreen.dart';
import './screens/JobEmployer/JobEmployerHomepage.dart';
import './screens/JobEmployer/JobPostScreen.dart';
import './screens/JobEmployer/JobApplicantListScreen.dart';
import './screens/JobEmployer/JobApplicationDetailScreen.dart';
import './screens/JobEmployer/JobPostingsPage.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    JobSeekerHomepage.routeName: (context) => JobSeekerHomepage(),
    SubCategoryPage.routeName: (context) => SubCategoryPage(
          categoryId: ModalRoute.of(context)!.settings.arguments as String,
          categoryName: '',
        ),
    JobDetailPage.routeName: (context) => JobDetailPage(),
    //JobApplicationScreen.routeName: (context) => JobApplications(),
    JobEmployerHomepage.routeName: (context) => JobEmployerHomepage(),
    JobPostScreen.routeName: (context) => JobPostScreen(),
    ApplicantsListScreen.routeName: (context) => ApplicantsListScreen(),
    EmployerJobsScreen.routeName: (context) => EmployerJobsScreen(),
  };
}
