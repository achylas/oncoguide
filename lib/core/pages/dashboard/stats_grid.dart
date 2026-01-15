import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';

class StatisticsHorizontal extends StatelessWidget {
  const StatisticsHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        "title": "Total Patients",
        "value": "156",
        "icon": Icons.people_rounded,
        "gradient": const LinearGradient(
            colors: [Color(0xFFFF6F91), Color(0xFFFF8FA3)]),
        "percentage": "+12%",
        "isPositive": true,
      },
      {
        "title": "Active Cases",
        "value": "48",
        "icon": Icons.local_hospital_rounded,
        "gradient": const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)]),
        "percentage": "+5%",
        "isPositive": true,
      },
      {
        "title": "Pending",
        "value": "12",
        "icon": Icons.pending_actions_rounded,
        "gradient": const LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFFB74D)]),
        "percentage": "-3%",
        "isPositive": false,
      },
      {
        "title": "This Week",
        "value": "23",
        "icon": Icons.calendar_today_rounded,
        "gradient": const LinearGradient(
            colors: [Color(0xFF26C6DA), Color(0xFF4DD0E1)]),
        "percentage": "+8%",
        "isPositive": true,
      },
    ];

    return SizedBox(
      height: 100, // slightly smaller height
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: stats.asMap().entries.map((entry) {
            final i = entry.key;
            final stat = entry.value;
            return Padding(
              padding: EdgeInsets.only(right: i == stats.length - 1 ? 0 : 10),
              child: StatCard(
                title: stat["title"] as String,
                value: stat["value"] as String,
                icon: stat["icon"] as IconData,
                gradient: stat["gradient"] as LinearGradient,
                percentage: stat["percentage"] as String,
                isPositive: stat["isPositive"] as bool,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final LinearGradient gradient;
  final String percentage;
  final bool isPositive;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
    required this.percentage,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = gradient.colors.last.withOpacity(0.35);

    return Container(
      width: 90, // smaller width for compact cards
      padding: const EdgeInsets.all(8), // tighter padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.successLight
                      : AppColors.warningLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 10,
                      color: isPositive ? AppColors.success : AppColors.warning,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      percentage,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color:
                            isPositive ? AppColors.success : AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
