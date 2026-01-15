import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // pubspec.yaml: animate_do: ^3.3.4 or latest
import 'package:oncoguide_frontend/core/conts/colors.dart'; // Assuming this is your AppColors file

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool _isEditing = false;

  // Controllers with initial values
  final TextEditingController _nameController =
      TextEditingController(text: "Dr. Sarah Jenkins");
  final TextEditingController _phoneController =
      TextEditingController(text: "+1 234 567 890");
  final TextEditingController _specController =
      TextEditingController(text: "Oncology Specialist");
  final TextEditingController _emailController =
      TextEditingController(text: "s.jenkins@medical.com");
  final TextEditingController _bioController = TextEditingController(
    text:
        "Dedicated breast cancer specialist with 12+ years of experience in early detection, personalized treatment strategies, and patient-centered care. Passionate about combining medical excellence with emotional support.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Subtle animated background gradient
          FadeIn(
            duration: const Duration(milliseconds: 1200),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.ribbonGradient.colors[0].withOpacity(0.12),
                    AppColors.background,
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Enhanced Header with animations
                  _buildEnhancedHeader(),

                  const SizedBox(height: 32),

                  // Quick Stats with staggered animation
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildQuickStats(),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Profile Details with glass-like cards & animations
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel("Professional Identity"),
                        const SizedBox(height: 12),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 900),
                          child: _buildDetailCard(
                            "Full Name",
                            _nameController,
                            Icons.person_outline_rounded,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInRight(
                          duration: const Duration(milliseconds: 1000),
                          child: _buildDetailCard(
                            "Specialization",
                            _specController,
                            Icons.medical_services_rounded,
                          ),
                        ),
                        const SizedBox(height: 32),

                        _buildSectionLabel("Contact Information"),
                        const SizedBox(height: 12),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 1100),
                          child: _buildDetailCard(
                            "Phone Number",
                            _phoneController,
                            Icons.phone_rounded,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInRight(
                          duration: const Duration(milliseconds: 1200),
                          child: _buildDetailCard(
                            "Email Address",
                            _emailController,
                            Icons.email_rounded,
                          ),
                        ),
                        const SizedBox(height: 32),

                        _buildSectionLabel("Professional Biography"),
                        const SizedBox(height: 12),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: _buildDetailCard(
                            "About Me",
                            _bioController,
                            Icons.description_rounded,
                            maxLines: 5,
                            minLines: 4,
                          ),
                        ),

                        const SizedBox(height: 100), // Space for FAB
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Enhanced FAB with scale animation
      floatingActionButton: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.0).animate(
          CurvedAnimation(
            parent: AlwaysStoppedAnimation(1.0),
            curve: Curves.elasticOut,
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_isEditing) {
              // You can add save logic here (e.g. call API, show snackbar)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Profile updated successfully"),
                  backgroundColor: AppColors.success,
                ),
              );
            }
            setState(() => _isEditing = !_isEditing);
          },
          backgroundColor: _isEditing ? AppColors.success : AppColors.primary,
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          icon: Icon(_isEditing ? Icons.save_rounded : Icons.edit_rounded),
          label: Text(
            _isEditing ? "Save Changes" : "Edit Profile",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildEnhancedHeader() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Curved background with subtle wave
        ClipPath(
          clipper: HeaderWaveClipper(),
          child: Container(
            height: 260,
            decoration: BoxDecoration(
              gradient: AppColors.ribbonGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.25),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
        ),

        // Decorative floating elements
        Positioned(
          top: 40,
          right: 30,
          child: Pulse(
            duration: const Duration(milliseconds: 1800),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ),
        ),

        Positioned(
          top: 90,
          left: 40,
          child: Pulse(
            duration: const Duration(milliseconds: 2200),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
            ),
          ),
        ),

        // Main profile content
        Column(
          children: [
            const SizedBox(height: 50),

            // Avatar with glow & edit overlay
            ZoomIn(
              duration: const Duration(milliseconds: 1000),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.accentGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryDark.withOpacity(0.35),
                          blurRadius: 25,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: CircleAvatar(
                      radius: 68,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 62,
                        backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                        ),
                        // Alternative: 'https://i.pravatar.cc/300?img=45'
                      ),
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Implement image picker
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFE91E63),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Name with elegant typography
          ],
        ),

        // Back button
        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statCard("150+", "Patients", const Color(0xFF1976D2),
              Icons.people_alt_rounded),
          _statCard(
              "12+", "Years", const Color(0xFF388E3C), Icons.timeline_rounded),
          _statCard(
              "4.9", "Rating", const Color(0xFFE91E63), Icons.star_rounded),
        ],
      ),
    );
  }

  Widget _statCard(
    String value,
    String label,
    Color accentColor,
    IconData icon,
  ) {
    return Expanded(
      child: BounceInUp(
        duration: const Duration(milliseconds: 1000),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: accentColor.withOpacity(0.7),
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: accentColor,
                size: 24, // smaller icon
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20, // reduced from 26
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11.5, // smaller label text
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
    String label,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
    int minLines = 1,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isEditing ? Color(0xFFE91E63) : AppColors.border,
          width: _isEditing ? 2.5 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: _isEditing
                ? AppColors.primary.withOpacity(0.18)
                : AppColors.shadowLight,
            blurRadius: _isEditing ? 16 : 10,
            spreadRadius: _isEditing ? 2 : 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: controller,
                  enabled: _isEditing,
                  maxLines: maxLines,
                  minLines: minLines,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// Custom clipper for wave header
class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);

    final firstControlPoint = Offset(size.width * 0.25, size.height);
    final firstEndPoint = Offset(size.width * 0.5, size.height - 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height - 80);
    final secondEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
