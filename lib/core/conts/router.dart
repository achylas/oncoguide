import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/pages/auth/login.dart';
import 'package:oncoguide_frontend/core/pages/dashboard/dashboard_screen.dart';
import 'package:oncoguide_frontend/core/pages/new_analysis/screens/new_analysis_screen.dart';
import 'package:oncoguide_frontend/core/pages/profile.dart';
import 'package:oncoguide_frontend/core/pages/quickaccess/addpatient.dart';

class AppRoutes {
  // Route names
  static const String dashboard = '/';
  static const String addPatient = '/add_patient';
  static const String profile = '/profile';
  static const String new_analysis = '/new_analysis';
  static const String login = '/login';
  //static const String startAnalysis = '/analysis';
  static const String exportReports = '/export_reports';
  static const String quiz = '/quiz';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case addPatient:
        return MaterialPageRoute(builder: (_) => const AddPatientScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const DoctorProfileScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case new_analysis:
        return MaterialPageRoute(builder: (_) => const NewAnalysisScreen());
      //   return MaterialPageRoute(builder: (_) => const AnalysisScreen());
      // case exportReports:
      //   return MaterialPageRoute(builder: (_) => const ExportReportsScreen());
      // case quiz:
      //   return MaterialPageRoute(builder: (_) => const QuizScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
