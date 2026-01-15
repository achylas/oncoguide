import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';

class LearnMoreSection extends StatelessWidget {
  final bool showFullInfo;
  final VoidCallback onToggle;

  const LearnMoreSection({
    super.key,
    required this.showFullInfo,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: Color(0xFF6C63FF).withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        Icon(Icons.info_rounded, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      "What will the AI analyze?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    showFullInfo
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (showFullInfo) ...[
            Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _buildInfoItem(
                    icon: Icons.location_on_rounded,
                    title: "Tumor Location",
                    description: "Precise position & size measurements",
                    color: Color(0xFFFF6F91),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    icon: Icons.analytics_rounded,
                    title: "Diagnosis",
                    description: "Cancer type, grade & characteristics",
                    color: Color(0xFF6C63FF),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    icon: Icons.account_tree_rounded,
                    title: "TNM Staging",
                    description: "Complete staging with lymph node analysis",
                    color: Color(0xFFFFA726),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    icon: Icons.psychology_alt_rounded,
                    title: "AI Explanation",
                    description: "Clear reasoning behind predictions",
                    color: Color(0xFF26C6DA),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    icon: Icons.favorite_rounded,
                    title: "Lifestyle Tips",
                    description: "Personalized diet & exercise recommendations",
                    color: Color(0xFF2ECC71),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    icon: Icons.local_hospital_rounded,
                    title: "Treatment Plan",
                    description: "Evidence-based next steps",
                    color: Color(0xFFEF5350),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
