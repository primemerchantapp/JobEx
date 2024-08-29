import 'package:flutter/material.dart';
import 'package:jobizz/widgets/HomeAppBarWidget.dart';
import 'package:provider/provider.dart';
import '../../widgets/AppBarWidget.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/SearchWidget.dart';
import '../../providers/jobs_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/TitleText.dart';
import '../../widgets/GridJobsTiles.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  static const routeName = '/sub-category';
  final String categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          height: AppTheme.fullHeight(context) - 50,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeAppBarWidget(),
              _title(categoryName),
              Expanded(
                child: Consumer<Jobs>(
                  builder: (context, jobsProvider, child) {
                    final categoryJobs = jobsProvider.jobs
                        .where((job) => job.category == categoryId)
                        .toList();

                    if (categoryJobs.isEmpty) {
                      return Center(
                        child: Text('No jobs available in this category.'),
                      );
                    }

                    return GridView.builder(
                      padding: AppTheme.padding,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categoryJobs.length,
                      itemBuilder: (ctx, i) =>
                          GridJobTiles(job: categoryJobs[i]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String categoryName) {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: '$categoryName \nJobs',
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
