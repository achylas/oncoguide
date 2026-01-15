import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/conts/colors.dart';
import 'package:oncoguide_frontend/core/pages/dashboard/dashboard_screen.dart';
import 'package:oncoguide_frontend/core/pages/new_analysis/screens/new_analysis_screen.dart';
import '../pages/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const NewAnalysisScreen(),
    const DoctorProfileScreen(),
  ];

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

// ────────────────────────────────────────────────

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Container(
      color: Colors.transparent, // important – prevents background bleed
      padding: const EdgeInsets.only(
        bottom: 12,
        left: 16,
        right: 16,
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          height: 76,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // ─── Background pill ───────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.11),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavItem(
                        icon: Icons.home_outlined,
                        isSelected: selectedIndex == 0,
                        onTap: () => onTap(0),
                      ),
                      const SizedBox(
                          width: 80), // space for floating scan button
                      _NavItem(
                        icon: Icons.person_outline,
                        isSelected: selectedIndex == 2,
                        onTap: () => onTap(2),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Floating Scan Button ──────────────────────────
              Positioned(
                bottom: 28, // controls how high it "pops" above the bar
                child: GestureDetector(
                  onTap: () => onTap(1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    height: selectedIndex == 1 ? 78 : 72,
                    width: selectedIndex == 1 ? 78 : 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFBA6BFA),
                          Color(0xFFFF6B6B),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B6B).withOpacity(0.4),
                          blurRadius: selectedIndex == 1 ? 18 : 12,
                          spreadRadius: selectedIndex == 1 ? 4 : 0,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.20),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: selectedIndex == 1 ? 38 : 34,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey.shade500,
          size: isSelected ? 30 : 26,
        ),
      ),
    );
  }
}
