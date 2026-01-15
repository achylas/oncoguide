import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';

class SectionHeader extends StatelessWidget {
  final String step;
  final String title;
  final bool isLocked;

  const SectionHeader({
    super.key,
    required this.step,
    required this.title,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLocked
                  ? [AppColors.border, AppColors.border]
                  : [Color(0xFFFF6F91), Color(0xFFFF8FA3)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            step,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isLocked ? AppColors.textSecondary : Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        if (isLocked) ...[
          const SizedBox(width: 8),
          Icon(
            Icons.lock_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ],
      ],
    );
  }
}
