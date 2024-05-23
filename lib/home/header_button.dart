import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class HeaderButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isDarkMode;
  final IconData icon;

  HeaderButton(
      {required this.title,
      required this.onPressed,
      this.isSelected = false,
      required this.isDarkMode,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: MediaQuery.of(context).size.width < 900
          ? Icon(
              icon,
              color: isSelected
                  ? AppColors.gold
                  : isDarkMode
                      ? AppColors.lightGrey
                      : AppColors.black,
              weight: 0.2,
            )
          : Text(
              title,
              style: GoogleFonts.inter(
                color: isSelected
                    ? AppColors.gold
                    : isDarkMode
                        ? AppColors.lightGrey
                        : AppColors.black,
                fontSize: 14,
              ),
            ),
    );
  }
}
