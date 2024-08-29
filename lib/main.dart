import 'package:flutter/material.dart';
import 'package:jobizz/screens/JobEmployer/JobEmployerHomepage.dart';
import 'package:jobizz/screens/JobSeeker/JobSeekerHomepage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/category_provider.dart';
import './providers/jobs_provider.dart';
import 'theme/app_theme.dart';
import 'routes.dart';
import 'firebase_options.dart';
import './providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Jobs()),
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => CategoryProvider()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Jobizz',
          theme: AppTheme.lightTheme,
          home: JobEmployerHomepage(),
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
