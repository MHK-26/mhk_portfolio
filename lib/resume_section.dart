import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/colors.dart';
import 'package:mhk_portfolio_flutter/resume_timeline.dart';

class ResumeSection extends StatelessWidget {
  final bool isDarkMode;

  ResumeSection({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: GoogleFonts.inter(
              color: isDarkMode ? AppColors.darkWhite : AppColors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Timeline(isDarkMode: isDarkMode),
        ],
      ),
    );
  }
}
