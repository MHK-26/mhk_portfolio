import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class FooterSection extends StatelessWidget {
  final bool isDarkMode;

  FooterSection({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            '© 2024 Mohammad Hisham. All rights reserved.',
            style: GoogleFonts.inter(
              color: isDarkMode ? AppColors.darkWhite : AppColors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            '',
            style: GoogleFonts.inter(
              color: isDarkMode ? AppColors.darkWhite : AppColors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
