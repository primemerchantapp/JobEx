import 'package:flutter/material.dart';
import 'package:jobizz/widgets/TitleText.dart';
import '../providers/jobs_provider.dart';
import '../screens/JobSeeker/JobDetailScreen.dart';
import '../theme/color.dart';

class GridJobTiles extends StatelessWidget {
  final Job job;

  GridJobTiles({required this.job});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          JobDetailPage.routeName,
          arguments: job.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 15,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  job.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: job.title,
                      isSubtitle: true,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4),
                    TitleText(
                      text: '${job.salary} Per ${job.rate}',
                      fontSize: 12,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
