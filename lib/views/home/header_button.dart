import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;

  const MyAppBar({
    super.key,
    required this.isDarkMode,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: isDarkMode ? AppColors.darkWhite : AppColors.black,
      ),
      title: Text(
        'MHK\'s Portfolio',
        style: GoogleFonts.inter(
          color: isDarkMode ? AppColors.darkWhite : AppColors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(),
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode))
        // Switch(
        //   value: isDarkMode,
        //   onChanged: (value) {
        //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        //   },
        // ),
      ],
    );
  }
}
