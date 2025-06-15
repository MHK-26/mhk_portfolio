import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class CustomNavigationBar extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final Function(String) onSectionTap;
  final String currentSection;

  const CustomNavigationBar({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onSectionTap,
    required this.currentSection,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isScrolled = false;

  final List<Map<String, dynamic>> _navigationItems = [
    {'title': 'Home', 'section': 'hero'},
    {'title': 'About', 'section': 'about'},
    {'title': 'Experience', 'section': 'experience'},
    {'title': 'Projects', 'section': 'projects'},
    {'title': 'Certifications', 'section': 'certifications'},
    {'title': 'Contact', 'section': 'contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 768;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80,
          decoration: BoxDecoration(
            color: widget.isDarkMode 
                ? Colors.black.withOpacity(0.9)
                : Colors.white.withOpacity(0.9),
            border: Border(
              bottom: BorderSide(
                color: AppColors.gold.withOpacity(0.2),
                width: 1,
              ),
            ),
            boxShadow: _isScrolled ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ] : [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildLogo(),
                const Spacer(),
                if (!isMobile) ...[
                  _buildDesktopNavigation(),
                  const SizedBox(width: 20),
                ],
                _buildThemeToggle(),
                if (isMobile) _buildMobileMenuButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return InkWell(
      onTap: () => widget.onSectionTap('hero'),
      child: Row(
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
                  color: widget.isDarkMode ? AppColors.white : AppColors.black,
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
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      children: _navigationItems.map((item) {
        final isActive = widget.currentSection == item['section'];
        
        return Container(
          margin: const EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () => widget.onSectionTap(item['section']),
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive 
                    ? AppColors.gold.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: isActive 
                    ? Border.all(color: AppColors.gold.withOpacity(0.3))
                    : null,
              ),
              child: Text(
                item['title'],
                style: GoogleFonts.inter(
                  color: isActive 
                      ? AppColors.gold
                      : widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.8)
                          : AppColors.black.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThemeToggle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: widget.onThemeToggle,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey(widget.isDarkMode),
              color: AppColors.gold,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: InkWell(
        onTap: () => _showMobileMenu(context),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.menu,
            color: widget.isDarkMode ? AppColors.white : AppColors.black,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ..._navigationItems.map((item) {
              final isActive = widget.currentSection == item['section'];
              
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  widget.onSectionTap(item['section']);
                },
                title: Text(
                  item['title'],
                  style: GoogleFonts.inter(
                    color: isActive 
                        ? AppColors.gold
                        : widget.isDarkMode 
                            ? AppColors.darkWhite
                            : AppColors.black,
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                trailing: isActive 
                    ? Icon(Icons.check, color: AppColors.gold, size: 20)
                    : null,
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}