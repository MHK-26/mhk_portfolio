import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/info/social_links.dart';

class ProfileCard extends StatelessWidget {
  final bool isDarkMode;

  const ProfileCard({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.black87, Colors.black54]
              : [Colors.white, Colors.grey[200]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 75,
            backgroundImage: AssetImage('assets/imgs/pp.jpeg'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 20),
          Text(
            'Mohammad Hisham',
            style: GoogleFonts.inter(
              color: isDarkMode ? AppColors.white : AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          AnimatedTextKit(
            animatedTexts: [
              _buildTypewriterAnimatedText('Back-End Developer'),
              _buildTypewriterAnimatedText('Flutter Developer'),
              _buildTypewriterAnimatedText('Cloud Architect'),
              _buildTypewriterAnimatedText('Software Engineer'),
            ],
            repeatForever: true,
          ),
          const SizedBox(height: 20),
          SocialLinks(isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  TypewriterAnimatedText _buildTypewriterAnimatedText(String text) {
    return TypewriterAnimatedText(
      text,
      textStyle: GoogleFonts.inter(
        color: isDarkMode ? AppColors.darkWhite : AppColors.grey,
        fontSize: 16,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }
}
