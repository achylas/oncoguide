import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';
import 'package:oncoguide_frontend/core/pages/dashboard/patient_card.dart';
import 'package:oncoguide_frontend/core/pages/dashboard/quick_actions.dart';
import 'package:oncoguide_frontend/core/pages/dashboard/report_card.dart';
import 'package:oncoguide_frontend/core/pages/history/scan_history/scan_history_screen.dart';
import 'top_bar.dart';
// import 'welcome_card.dart';
import 'stats_grid.dart';
import 'package:oncoguide_frontend/core/utils/animations.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    const doctorName = "Dr. Sarah Hassan";

    final patients = [
      {
        "name": "Aisha Khan",
        "age": 45,
        "stage": "Stage II",
        "lastCheckup": "05-Jan-2026",
        "status": "Stable"
      },
      {
        "name": "Fatima Ali",
        "age": 52,
        "stage": "Stage III",
        "lastCheckup": "02-Jan-2026",
        "status": "Under Treatment"
      },
      {
        "name": "Sara Ahmed",
        "age": 38,
        "stage": "Stage I",
        "lastCheckup": "08-Jan-2026",
        "status": "Stable"
      },
      {
        "name": "Hina Malik",
        "age": 60,
        "stage": "Stage IV",
        "lastCheckup": "30-Dec-2025",
        "status": "Critical"
      },
    ];

    return Column(
      children: [
        EnhancedTopBar(
          doctorName: doctorName,
          onProfileTap: () => Navigator.pushNamed(context, '/profile'),
          onNotificationTap: () =>
              Navigator.pushNamed(context, '/notifications'),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: WelcomeCard(doctorName: doctorName),
                // ),
                SectionTitle("Overview Statistics"),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: StatisticsHorizontal(),
                ),
                const SizedBox(height: 28),
                SectionTitle("Quick Actions"),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: EnhancedQuickActions(),
                ),
                const SizedBox(height: 32),

                // RECENT SCANS - Navigate to Scan History
                SectionHeader(
                  "Recent Scans",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanHistoryPage(
                          patientId:
                              'current_patient_id', // Replace with actual patient ID
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 6,
                    itemBuilder: (_, i) => Animations.slideUp(
                      delay: i * 100,
                      child: CompactReportCard(
                        reportName: "Scan Report #${201 + i}",
                        patientName: i == 0
                            ? "Aisha Khan"
                            : i == 1
                                ? "Fatima Ali"
                                : "Sara Ahmed",
                        date: "10-Jan-2026",
                        status: i % 3 == 0
                            ? "Malignant"
                            : i % 3 == 1
                                ? "Benign"
                                : "Normal",
                        index: i,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // PATIENT OVERVIEW
                SectionHeader("Patient Overview", onTap: () {
                  // You can navigate to a patients list page here if needed
                  // Navigator.pushNamed(context, '/patients');
                }),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: patients.length,
                    itemBuilder: (_, i) {
                      final p = patients[i];
                      return Animations.slideUp(
                        delay: i * 100,
                        child: EnhancedPatientCard(
                          name: p["name"] as String,
                          lastCheckup: AutofillHints.addressCity,
                          age: p["age"] as int,
                          stage: p["stage"] as String,
                          status: p["status"] as String,
                          index: i,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget SectionTitle(String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
      ),
    );

Widget SectionHeader(String title, {required VoidCallback onTap}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: const [
                  Text(
                    "View All",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
