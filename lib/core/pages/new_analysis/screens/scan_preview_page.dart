// scan_preview_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';
import 'package:oncoguide_frontend/core/utils/common_app_bar.dart';

class ScanPreviewPage extends StatefulWidget {
  final File imageFile;
  final String scanType;

  const ScanPreviewPage({
    super.key,
    required this.imageFile,
    required this.scanType,
  });

  @override
  State<ScanPreviewPage> createState() => _ScanPreviewPageState();
}

class _ScanPreviewPageState extends State<ScanPreviewPage> {
  bool _isAnalyzing = false;

  Future<void> _confirm() async {
    setState(() => _isAnalyzing = true);
    // Optional: small fake delay to feel like processing
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    // Return the image file to the caller (NewAnalysisScreen)
    Navigator.pop(context, widget.imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonTopBar(title: 'Scan Preview'),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _buildMainContent(),
          if (_isAnalyzing)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Confirming...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.primary.withOpacity(0.4), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(
                  widget.imageFile,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Ensure the image is clear and properly aligned.\n'
            'AI analysis accuracy depends on image quality.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      _isAnalyzing ? null : () => Navigator.pop(context, null),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retake'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.accent,
                    side: const BorderSide(color: AppColors.accent),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isAnalyzing ? null : _confirm,
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
