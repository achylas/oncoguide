import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';

class EnhancedPatientCard extends StatelessWidget {
  final String name;
  final int age;
  final String stage;
  final String lastCheckup;
  final String status;
  final int index;

  const EnhancedPatientCard({
    super.key,
    required this.name,
    required this.age,
    required this.stage,
    required this.lastCheckup,
    required this.status,
    required this.index,
  });

  Color getStatusColor() {
    switch (status) {
      case "Critical":
        return AppColors.danger;
      case "Under Treatment":
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor();
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.65; // smaller width
    return Container(
      width: cardWidth,
      margin: EdgeInsets.only(right: 12, left: index == 0 ? 0 : 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, color.withOpacity(0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // prevents vertical overflow
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + Name
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.2),
                child: Text(
                  name[0],
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "$age years",
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Info Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Stage
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Stage",
                          style: TextStyle(
                              fontSize: 10, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          stage,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    // Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        status,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: color),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "Last: $lastCheckup",
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
