import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mhk_portfolio_flutter/utils/background_painter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mhk_portfolio_flutter/widgets/focus_border.dart';

class HeroSection extends StatefulWidget {
  final bool isDarkMode;

  const HeroSection({super.key, required this.isDarkMode});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDarkMode
              ? [
                  Colors.black,
                  Colors.grey[900]!,
                  Colors.black,
                ]
              : [
                  Colors.white,
                  Colors.grey[50]!,
                  Colors.white,
                ],
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern using utility
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: AppColors.gold.withOpacity(0.05),
                isDarkMode: widget.isDarkMode,
              ),
            ),
          ),
          
          // Main Content
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 768;
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildProfileSection(isMobile),
                          SizedBox(height: isMobile ? 30 : 40),
                          _buildAnimatedRole(isMobile),
                          SizedBox(height: isMobile ? 30 : 40),
                          _buildDescription(isMobile),
                          SizedBox(height: isMobile ? 40 : 50),
                          _buildActionButtons(isMobile),
                          SizedBox(height: isMobile ? 30 : 40),
                          _buildScrollIndicator(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildProfileSection(bool isMobile) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.gold.withOpacity(0.4),
                AppColors.gold.withOpacity(0.1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(6),
            child: CircleAvatar(
              radius: isMobile ? 50 : 60,
              backgroundImage: const AssetImage('assets/imgs/pp.jpeg'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Mohammad Hisham',
          style: GoogleFonts.poppins(
            color: widget.isDarkMode ? AppColors.white : AppColors.black,
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
     
      ],
    );
  }


  Widget _buildAnimatedRole(bool isMobile) {
    return SizedBox(
      height: isMobile ? 60 : 80,
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '🚀 Flutter Developer',
              textStyle: GoogleFonts.inter(
                color: AppColors.gold,
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w500,
              ),
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              '☁️ Cloud Architect',
              textStyle: GoogleFonts.inter(
                color: AppColors.gold,
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w500,
              ),
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              '🔧 Backend Developer',
              textStyle: GoogleFonts.inter(
                color: AppColors.gold,
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w500,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          repeatForever: true,
          isRepeatingAnimation: true,
        ),
      ),
    );
  }

  Widget _buildDescription(bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 350 : 500),
      child: Text(
        'Crafting exceptional digital experiences through innovative solutions. With 7+ years of expertise in full-stack development, cloud architecture, and mobile applications, I transform complex ideas into scalable, user-centric products that make a real impact.',
        style: GoogleFonts.inter(
          color: widget.isDarkMode 
              ? AppColors.darkWhite.withOpacity(0.8)
              : AppColors.black.withOpacity(0.7),
          fontSize: isMobile ? 16 : 18,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButtons(bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _buildSocialButton(
          'LinkedIn',
          Icons.work_outline,
          AppColors.gold,
          Colors.white,
          true,
          isMobile,
          'https://www.linkedin.com/in/mhk26',
        ),
        _buildSocialButton(
          'GitHub',
          Icons.code,
          Colors.transparent,
          widget.isDarkMode ? AppColors.white : AppColors.black,
          false,
          isMobile,
          'https://github.com/MHK-26',
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    String text,
    IconData icon,
    Color backgroundColor,
    Color textColor,
    bool filled,
    bool isMobile,
    String url,
  ) {
    return Semantics(
      button: true,
      label: 'Open $text profile',
      hint: 'Opens $text in a new tab',
      child: FocusBorder(
        child: ElevatedButton.icon(
          onPressed: () => _launchURL(url),
          icon: Icon(icon, size: isMobile ? 18 : 20),
          label: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: filled ? backgroundColor : Colors.transparent,
            foregroundColor: textColor,
            minimumSize: Size(120, isMobile ? 44 : 48), // Ensure proper touch targets
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 32,
              vertical: isMobile ? 16 : 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: filled 
                  ? BorderSide.none 
                  : BorderSide(color: AppColors.gold, width: 2),
            ),
            elevation: filled ? 8 : 0,
            shadowColor: AppColors.gold.withOpacity(0.3),
          ).copyWith(
            // Enhanced focus style
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return AppColors.gold.withOpacity(0.1);
              }
              if (states.contains(WidgetState.hovered)) {
                return AppColors.gold.withOpacity(0.05);
              }
              return null;
            }),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching URL: $e')),
        );
      }
    }
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Text(
          'Scroll to explore',
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.6)
                : AppColors.black.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 5 * _fadeController.value),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.gold,
                size: 24,
              ),
            );
          },
        ),
      ],
    );
  }
}