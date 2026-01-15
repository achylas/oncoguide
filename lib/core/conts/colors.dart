import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - soft, awareness-friendly
  static const primary = Color(0xFFFF6B9D); // Vibrant pink (ribbon)
  static const primaryLight = Color(0xFFFFB3CC); // Soft pink
  static const primaryDark = Color(0xFFE91E63); // Deep pink

  // Accent colors - complementary gentle tones
  static const accent = Color(0xFF74B9FF); // Light blue
  static const accentLight = Color(0xFFB3D9FF); // Soft baby blue
  static const accentPurple = Color(0xFFD1C4E9); // Light purple for contrast

  // Background colors
  static const background = Color(0xFFFDFDFD); // White-ish soft background
  static const cardBackground = Colors.white;
  static const surfaceLight = Color(0xFFFCE4EC); // Very light pink surface

  // Text colors
  static const textPrimary = Color(0xFF2D3436); // Charcoal
  static const textSecondary = Color(0xFF636E72); // Medium gray
  static const textTertiary = Color(0xFFB2BEC3); // Light gray

  // Status colors - Medical context
  static const success = Color(0xFF00B894); // Teal green
  static const successLight = Color(0xFFDFFFF7);

  static const warning = Color(0xFFFDAA63); // Warm orange
  static const warningLight = Color(0xFFFFF4E6);

  static const danger = Color(0xFFFF6B6B); // Soft red
  static const dangerLight = Color(0xFFFFE5E5);

  static const info = Color(0xFF74B9FF); // Soft blue
  static const infoLight = Color(0xFFE8F4FF);

  // Medical specific colors
  static const medicalPink = Color(0xFFFFC1E3); // Gentle pink
  static const medicalBlue = Color(0xFFB3D9FF); // Gentle blue

  // Gradient colors
  static const gradientPink1 = Color(0xFFFFB3CC); // Light pink
  static const gradientPink2 = Color(0xFFFF6B9D); // Medium pink
  static const gradientBlue1 = Color(0xFFB3D9FF); // Light blue
  static const gradientBlue2 = Color(0xFF74B9FF); // Soft blue

  static const gradientPurple1 = Color(0xFFD1C4E9);
  static const gradientPurple2 = Color(0xFFE1BEE7);

  // Border and divider colors
  static const border = Color(0xFFE0E0E0);
  static const divider = Color(0xFFB0BEC5);

  // Shadow colors
  static Color shadow = const Color(0xFFFF6B9D).withOpacity(0.12);
  static Color shadowLight = const Color(0xFF74B9FF).withOpacity(0.08);
  static Color shadowPink = const Color(0xFFFFB3CC).withOpacity(0.15);

  // Common gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientPink1, gradientPink2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [gradientBlue1, gradientBlue2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient healingGradient = LinearGradient(
    colors: [gradientPink1, gradientBlue2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [gradientPink2, gradientPurple2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient oceanGradient = LinearGradient(
    colors: [gradientBlue1, gradientBlue2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.white, surfaceLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Ribbon gradient - professional and awareness
  static const LinearGradient ribbonGradient = LinearGradient(
    colors: [gradientPink1, gradientPink2, gradientBlue2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Chart colors
  static const List<Color> chartColors = [
    gradientPink2,
    gradientPurple2,
    gradientBlue2,
    Color(0xFFE91E63),
    Color(0xFF74B9FF),
    Color(0xFFB3D9FF),
  ];

  // Semantic status colors
  static const statusCritical = Color.fromARGB(255, 244, 27, 27);
  static const statusUnderTreatment = Color(0xFFFDAA63);
  static const statusStable = Color(0xFF00B894);
  static const statusRecovered = Color(0xFF6BCBA0);
  static const stageColor = Color(0xFF3F51B5); // Indigo (clinical)
  static const severityHigh = Color(0xFFB71C1C); // Deep medical red
  static const severityMedium = Color(0xFFF57C00);
  static const severityLow = Color(0xFF2E7D32);

  static const borderIndigo = Color(0xFF9FA8DA);
  static const borderRed = Color(0xFFEF9A9A);
  static const borderBlueGrey = Color(0xFFB0BEC5);
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'critical':
        return statusCritical;
      case 'under treatment':
        return statusUnderTreatment;
      case 'stable':
        return statusStable;
      case 'recovered':
        return statusRecovered;
      default:
        return textSecondary;
    }
  }

  static LinearGradient getGradient(String name) {
    switch (name.toLowerCase()) {
      case 'primary':
        return primaryGradient;
      case 'accent':
        return accentGradient;
      case 'healing':
        return healingGradient;
      case 'sunset':
        return sunsetGradient;
      case 'ocean':
        return oceanGradient;
      case 'ribbon':
        return ribbonGradient;
      default:
        return primaryGradient;
    }
  }
}
