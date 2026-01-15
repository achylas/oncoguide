import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';

class CompactReportCard extends StatelessWidget {
  final String reportName;
  final String patientName;
  final String date;
  final String status;
  final int index;

  const CompactReportCard({
    super.key,
    required this.reportName,
    required this.patientName,
    required this.date,
    required this.status,
    required this.index,
  });

  Color getStatusColor() {
    switch (status) {
      case "Malignant":
        return AppColors.danger;
      case "Benign":
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  IconData getStatusIcon() {
    switch (status) {
      case "Malignant":
        return Icons.warning_rounded;
      case "Benign":
        return Icons.info_rounded;
      default:
        return Icons.check_circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor();
    return Container(
      width: 200, // smaller width
      margin: EdgeInsets.only(right: 12, left: index == 0 ? 0 : 0),
      padding: const EdgeInsets.all(12), // tighter padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: icon + status
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [color, color.withOpacity(0.7)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.description_rounded,
                    color: Colors.white, size: 18),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Icon(getStatusIcon(), size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(status,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: color))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Report & patient info
          Text(reportName,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(patientName,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          // Date & arrow
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded,
                  size: 12, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(date,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textSecondary)),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_rounded, size: 12, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
