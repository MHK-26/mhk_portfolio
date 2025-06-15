import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/info/social_links.dart';

class ProfileCard extends StatefulWidget {
  final bool isDarkMode;

  const ProfileCard({super.key, required this.isDarkMode});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> 
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
    
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_fadeController, _scaleController]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isDarkMode
                      ? [Colors.grey[850]!, Colors.grey[800]!]
                      : [Colors.white, Colors.grey[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileImage(),
                  const SizedBox(height: 30),
                  _buildNameSection(),
                  const SizedBox(height: 16),
                  _buildAnimatedRoles(),
                  const SizedBox(height: 30),
                  _buildStatsSection(),
                  const SizedBox(height: 30),
                  SocialLinks(isDarkMode: widget.isDarkMode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.3),
            AppColors.gold.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(4),
        child: const CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/imgs/pp.jpeg'),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildNameSection() {
    return Column(
      children: [
        Text(
          'Mohammad Hisham',
          style: GoogleFonts.poppins(
            color: widget.isDarkMode ? AppColors.white : AppColors.black,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Senior Developer',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedRoles() {
    return Container(
      height: 50,
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            _buildTypewriterAnimatedText('🚀 Flutter Developer'),
            _buildTypewriterAnimatedText('☁️ Cloud Architect'),
            _buildTypewriterAnimatedText('🔧 Back-End Developer'),
            _buildTypewriterAnimatedText('💻 Software Engineer'),
          ],
          repeatForever: true,
          isRepeatingAnimation: true,
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.isDarkMode 
            ? Colors.black.withOpacity(0.2)
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('5+', 'Years\nExperience'),
          _buildStatDivider(),
          _buildStatItem('20+', 'Projects\nCompleted'),
          _buildStatDivider(),
          _buildStatItem('10+', 'Certifications'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            color: AppColors.gold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.8)
                : AppColors.black.withOpacity(0.7),
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.gold.withOpacity(0.3),
    );
  }

  TypewriterAnimatedText _buildTypewriterAnimatedText(String text) {
    return TypewriterAnimatedText(
      text,
      textStyle: GoogleFonts.inter(
        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.grey,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }
}
