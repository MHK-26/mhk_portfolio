import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class InfoSection extends StatelessWidget {
  final bool isDarkMode;

  const InfoSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.black, Colors.grey[900]!]
              : [Colors.white, Colors.grey[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGreetingText(),
          const SizedBox(height: 20),
          _buildDescriptionText(),
          const SizedBox(height: 20),
          _buildSectionTitle('Tech Stack'),
          const SizedBox(height: 5),
          _buildTechStackIcons(),
        ],
      ),
    );
  }

  Text _buildGreetingText() {
    return Text(
      'Hi,',
      style: GoogleFonts.inter(
        color: isDarkMode ? AppColors.darkWhite : AppColors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: const Offset(2, 2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  RichText _buildDescriptionText() {
    return RichText(
      text: TextSpan(
        text: 'I\'m a Software Engineer with ',
        style: GoogleFonts.inter(
          color: isDarkMode ? AppColors.darkWhite : AppColors.black,
          fontSize: 16,
          height: 1.5,
        ),
        children: [
          _boldTextSpan('7+ years'),
          _normalTextSpan(' hands-on experience in:\n'),
          _boldTextSpan('Back-end Development'),
          _normalTextSpan(
              ': PHP, Laravel framework, Python, JavaScript, Java, Microservices, MySQL, and API Development and Integration, Scripting.\n'),
          _boldTextSpan('Mobile Applications Development'),
          _normalTextSpan(': Dart, Flutter framework (iOS and Android).\n'),
          _boldTextSpan('Software Product Management'),
          _normalTextSpan(': Jira, Agile Methodologies, Scrum.\n'),
          _boldTextSpan('Cloud and Network'),
          _normalTextSpan(': AWS SAA, GCP ACE, CCNA.\n'),
        ],
      ),
    );
  }

  TextSpan _boldTextSpan(String text) {
    return TextSpan(
      text: text,
      style: GoogleFonts.inter(
        color: isDarkMode ? AppColors.darkWhite : AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSpan _normalTextSpan(String text) {
    return TextSpan(
      text: text,
      style: GoogleFonts.inter(
        color: isDarkMode ? AppColors.darkWhite : AppColors.black,
      ),
    );
  }

  Text _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: isDarkMode ? AppColors.darkWhite : AppColors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: const Offset(2, 2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Wrap _buildTechStackIcons() {
    const iconSize = 35.0;
    const iconPaths = [
      'assets/icons/flutter.png',
      'assets/icons/dart.png',
      'assets/icons/java.png',
      'assets/icons/php.png',
      'assets/icons/laravel.png',
      'assets/icons/html.png',
      'assets/icons/python.png',
      'assets/icons/gcp.png',
      'assets/icons/aws.png',
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: iconPaths
          .map((path) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(path, width: iconSize, height: iconSize),
              ))
          .toList(),
    );
  }
}
