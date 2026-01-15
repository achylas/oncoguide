import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';

import '../screens/new_analysis_screen.dart'; // for ImagingType enum

class ProgressCard extends StatelessWidget {
  final bool tabularAdded;
  final Set<ImagingType> selectedImaging;

  const ProgressCard({
    super.key,
    required this.tabularAdded,
    required this.selectedImaging,
  });

  @override
  Widget build(BuildContext context) {
    final totalSteps = 2;
    final completedSteps =
        (tabularAdded ? 1 : 0) + (selectedImaging.isNotEmpty ? 1 : 0);
    final progress = completedSteps / totalSteps;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Progress",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$completedSteps of $totalSteps steps completed",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: progress == 1.0
                        ? [AppColors.success, Color(0xFF58D68D)]
                        : [Color(0xFFFFA726), Color(0xFFFFB74D)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: (progress == 1.0
                              ? AppColors.success
                              : Color(0xFFFFA726))
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 8,
              decoration: BoxDecoration(color: AppColors.background),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: progress == 1.0
                          ? [AppColors.success, Color(0xFF58D68D)]
                          : [Color(0xFFFF6F91), Color(0xFFFF8FA3)],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
