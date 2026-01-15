import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/pages/new_analysis/screens/new_analysis_screen.dart';
import 'package:oncoguide_frontend/core/utils/common_app_bar.dart';

class ScanResultPage extends StatelessWidget {
  final Map<String, dynamic> selectedPatient;
  final Map<ImagingType, File?> uploadedImages;
  final Set<ImagingType> selectedImagingTypes;

  const ScanResultPage({
    super.key,
    required this.selectedPatient,
    required this.uploadedImages,
    required this.selectedImagingTypes,
  });

  @override
  Widget build(BuildContext context) {
    // Extract patient info
    final String patientName =
        selectedPatient['name']?.toString() ?? 'Unknown Patient';
    final int age = (selectedPatient['age'] as num?)?.toInt() ?? 0;
    final String statusOrHistory =
        selectedPatient['medicalHistory']?.toString() ??
            selectedPatient['status']?.toString() ??
            'No additional info';

    // Mock AI Output Data
    final String diagnosis = "Malignant Tumor Detected";
    final String stage = "Stage II";
    final String severity = "High Risk";
    final String tnm = "T2  N1  M0";
    final String tumorSize = "2.8 cm";
    final String lymphNodes = "1–3 nodes involved";
    final double confidence = 92.4;
    final int riskScore = 78;

    return Scaffold(
      appBar: const CommonTopBar(title: 'Analysis Results'),
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ═══════════════════════════════════════════════════════
            // SECTION 1: PATIENT INFORMATION
            // ═══════════════════════════════════════════════════════
            _buildPatientHeader(patientName, age, statusOrHistory),
            const SizedBox(height: 28),

            // ═══════════════════════════════════════════════════════
            // SECTION 2: AI DIAGNOSIS - PRIMARY ALERT
            // ═══════════════════════════════════════════════════════
            _buildDiagnosisAlert(
              diagnosis: diagnosis,
              confidence: confidence,
              scanType: _getScanTypeLabel(),
            ),
            const SizedBox(height: 28),

            // ═══════════════════════════════════════════════════════
            // SECTION 3: KEY CLINICAL METRICS (GRID)
            // ═══════════════════════════════════════════════════════
            _buildClinicalMetricsGrid(stage, severity, tnm, riskScore),
            const SizedBox(height: 28),

            // ═══════════════════════════════════════════════════════
            // SECTION 4: TUMOR CHARACTERISTICS
            // ═══════════════════════════════════════════════════════
            _buildSectionCard(
              title: "Tumor Characteristics",
              icon: Icons.biotech_rounded,
              iconColor: const Color(0xFF6366F1),
              child: Column(
                children: [
                  _buildInfoRow(
                    label: "TNM Classification",
                    value: tnm,
                    icon: Icons.grid_on_outlined,
                  ),
                  _buildDivider(),
                  _buildInfoRow(
                    label: "Tumor Size",
                    value: tumorSize,
                    icon: Icons.straighten_outlined,
                  ),
                  _buildDivider(),
                  _buildInfoRow(
                    label: "Lymph Node Status",
                    value: lymphNodes,
                    icon: Icons.blur_circular_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ═══════════════════════════════════════════════════════
            // SECTION 5: UPLOADED IMAGING
            // ═══════════════════════════════════════════════════════
            if (selectedImagingTypes.isNotEmpty) ...[
              _buildSectionCard(
                title: "Imaging Studies",
                icon: Icons.medical_information_rounded,
                iconColor: const Color(0xFF8B5CF6),
                child: Column(
                  children: selectedImagingTypes.map((type) {
                    final file = uploadedImages[type];
                    if (file == null) return const SizedBox.shrink();
                    return _buildImagePreview(type, file);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // ═══════════════════════════════════════════════════════
            // SECTION 6: CLINICAL FINDINGS
            // ═══════════════════════════════════════════════════════
            _buildSectionCard(
              title: "Clinical Findings",
              icon: Icons.description_rounded,
              iconColor: const Color(0xFF0EA5E9),
              child: Text(
                "AI analysis indicates irregular mass density with spiculated "
                "margins, a hallmark feature of malignant breast lesions. "
                "The staging suggests localized disease with limited lymph "
                "node involvement and no distant metastasis detected.",
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.7,
                  color: Colors.grey[700],
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ═══════════════════════════════════════════════════════
            // SECTION 7: RECOMMENDATIONS
            // ═══════════════════════════════════════════════════════
            _buildSectionCard(
              title: "Clinical Recommendations",
              icon: Icons.fact_check_rounded,
              iconColor: const Color(0xFF10B981),
              child: Column(
                children: const [
                  _RecommendationItem(
                    text: "Immediate biopsy confirmation is advised",
                    priority: RecommendationPriority.urgent,
                  ),
                  _RecommendationItem(
                    text: "Refer to oncology specialist within 7 days",
                    priority: RecommendationPriority.high,
                  ),
                  _RecommendationItem(
                    text: "Contrast-enhanced MRI recommended for staging",
                    priority: RecommendationPriority.medium,
                  ),
                  _RecommendationItem(
                    text: "Discuss findings in multidisciplinary tumor board",
                    priority: RecommendationPriority.medium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ═══════════════════════════════════════════════════════
            // SECTION 8: MEDICAL DISCLAIMER
            // ═══════════════════════════════════════════════════════
            _buildDisclaimer(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // PATIENT HEADER - Clean, professional header with avatar
  // ═══════════════════════════════════════════════════════════════
  Widget _buildPatientHeader(String name, int age, String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar with gradient
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Patient info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.cake_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$age years',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // DIAGNOSIS ALERT - Primary alert card with high visibility
  // ═══════════════════════════════════════════════════════════════
  Widget _buildDiagnosisAlert({
    required String diagnosis,
    required double confidence,
    required String scanType,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFF87171)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "AI-Assisted Diagnosis",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            diagnosis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMetaChip(
                icon: Icons.device_hub,
                label: scanType,
              ),
              const SizedBox(width: 10),
              _buildMetaChip(
                icon: Icons.analytics_outlined,
                label: "Confidence ${confidence.toStringAsFixed(1)}%",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // CLINICAL METRICS GRID - 2x2 grid of key metrics
  // ═══════════════════════════════════════════════════════════════
  Widget _buildClinicalMetricsGrid(
      String stage, String severity, String tnm, int riskScore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Clinical Overview",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: "Cancer Stage",
                value: stage,
                subtitle: "Localized",
                icon: Icons.account_tree_rounded,
                color: const Color(0xFFFF9800),
                lightColor: const Color(0xFFFFF3E0),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: "Severity",
                value: severity,
                subtitle: "Requires urgent attention",
                icon: Icons.emergency_rounded,
                color: const Color(0xFFEF4444),
                lightColor: const Color(0xFFFEE2E2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: "TNM Stage",
                value: tnm,
                subtitle: "T2 N1 M0",
                icon: Icons.category_rounded,
                color: const Color(0xFF8B5CF6),
                lightColor: const Color(0xFFF3E8FF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: "Risk Score",
                value: "$riskScore%",
                subtitle: "Aggressive potential",
                icon: Icons.speed_rounded,
                color: const Color(0xFFDC2626),
                lightColor: const Color(0xFFFEE2E2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color lightColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION CARD - Reusable section container
  // ═══════════════════════════════════════════════════════════════
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // INFO ROW - Key-value pair with icon
  // ═══════════════════════════════════════════════════════════════
  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // IMAGE PREVIEW - Medical imaging display
  // ═══════════════════════════════════════════════════════════════
  Widget _buildImagePreview(ImagingType type, File file) {
    final String typeName =
        type == ImagingType.mammogram ? "Mammogram" : "Ultrasound";

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  type == ImagingType.mammogram
                      ? Icons.monitor_heart_outlined
                      : Icons.waves_outlined,
                  size: 16,
                  color: const Color(0xFF8B5CF6),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                typeName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.file(
                file,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // DISCLAIMER - Medical disclaimer notice
  // ═══════════════════════════════════════════════════════════════
  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFBBF24).withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.info_rounded,
              color: Color(0xFFF59E0B),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Important Medical Notice",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "This is an AI-assisted assessment and must be reviewed and validated by a qualified medical professional before any clinical decision-making. This analysis does not replace professional medical diagnosis.",
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.6,
                    color: Colors.brown[800],
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════
  String _getScanTypeLabel() {
    if (selectedImagingTypes.length > 1) {
      return "Multi-modal Analysis";
    }
    return selectedImagingTypes.first == ImagingType.mammogram
        ? "Mammogram"
        : "Ultrasound";
  }
}

// ═══════════════════════════════════════════════════════════════
// RECOMMENDATION ITEM - Enhanced with priority indicators
// ═══════════════════════════════════════════════════════════════
enum RecommendationPriority { urgent, high, medium }

class _RecommendationItem extends StatelessWidget {
  final String text;
  final RecommendationPriority priority;

  const _RecommendationItem({
    required this.text,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    IconData priorityIcon;

    switch (priority) {
      case RecommendationPriority.urgent:
        priorityColor = const Color(0xFFEF4444);
        priorityIcon = Icons.emergency;
        break;
      case RecommendationPriority.high:
        priorityColor = const Color(0xFFF59E0B);
        priorityIcon = Icons.priority_high;
        break;
      case RecommendationPriority.medium:
        priorityColor = const Color(0xFF10B981);
        priorityIcon = Icons.check_circle_outline;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: priorityColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: priorityColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              priorityIcon,
              size: 18,
              color: priorityColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
                if (priority == RecommendationPriority.urgent) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "URGENT",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
