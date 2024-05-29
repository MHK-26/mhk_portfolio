import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class ContactPage extends StatelessWidget {
  final bool isDarkMode;

  const ContactPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          'In the meantime, feel free to connect with me on social media platforms.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: isDarkMode ? AppColors.darkWhite : AppColors.black,
          ),
        ),
      ),
    );
  }
}
