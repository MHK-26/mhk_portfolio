import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/info/info_section.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:provider/provider.dart';

class ProfileInfoSection extends StatelessWidget {
  final bool isDarkMode;
  final bool showHeader;

  const ProfileInfoSection({
    super.key, 
    required this.isDarkMode,
    this.showHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [Colors.grey[900]!, Colors.black]
              : [Colors.grey[50]!, Colors.white],
        ),
      ),
      child: Column(
        children: [
          if (showHeader) _buildHeader(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: InfoSection(isDarkMode: isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isDarkMode 
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.3),
        border: Border(
          bottom: BorderSide(
            color: AppColors.gold.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _buildLogo(),
            const Spacer(),
            _buildThemeToggle(themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'M',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mohammad Hisham',
              style: GoogleFonts.poppins(
                color: isDarkMode ? AppColors.white : AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Software Engineer',
              style: GoogleFonts.inter(
                color: AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => themeProvider.toggleTheme(),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey(isDarkMode),
              color: AppColors.gold,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

}
