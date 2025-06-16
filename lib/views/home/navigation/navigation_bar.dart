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
    {'title': 'Projects', 'section': 'projects'},
    {'title': 'Certifications', 'section': 'certifications'},
    {'title': 'Blog', 'section': 'blog'},
    {'title': 'Contact', 'section': 'contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 840; // Increased threshold to prevent overflow
        bool isTablet = constraints.maxWidth < 1024 && constraints.maxWidth >= 840;
        
        return Semantics(
          container: true,
          header: true,
          label: 'Main navigation',
          child: AnimatedContainer(
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
                    Flexible(
                      child: _buildDesktopNavigation(constraints.maxWidth),
                    ),
                    const SizedBox(width: 8),
                  ],
                  _buildThemeToggle(),
                  if (isMobile) _buildMobileMenuButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isVerySmall = constraints.maxWidth < 400;
        
        return Semantics(
          button: true,
          label: 'Mohammad Hisham Portfolio Home',
          hint: 'Navigate to home section',
          child: InkWell(
            onTap: () => widget.onSectionTap('hero'),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                      semanticsLabel: 'Logo',
                    ),
                  ),
                ),
              if (!isVerySmall) ...[
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
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
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Software Engineer',
                        style: GoogleFonts.inter(
                          color: AppColors.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
      },
    );
  }

  Widget _buildDesktopNavigation(double maxWidth) {
    bool isCompact = maxWidth < 1024;
    bool isVeryCompact = maxWidth < 900;
    
    // Use horizontal scrollable navigation for smaller screens
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isVeryCompact ? maxWidth * 0.5 : maxWidth * 0.6,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _navigationItems.map((item) {
            final isActive = widget.currentSection == item['section'];
            
            return Container(
              margin: EdgeInsets.only(right: isVeryCompact ? 2 : (isCompact ? 4 : 8)),
              child: Semantics(
                button: true,
                label: 'Navigate to ${item['title']} section',
                selected: isActive,
                child: InkWell(
                  onTap: () => widget.onSectionTap(item['section']),
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: isVeryCompact ? 6 : (isCompact ? 10 : 16), 
                      vertical: 8
                    ),
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
                        fontSize: isVeryCompact ? 11 : (isCompact ? 13 : 14),
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
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
      child: Semantics(
        button: true,
        label: widget.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
        hint: 'Toggle between dark and light themes',
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
                semanticLabel: widget.isDarkMode ? 'Light mode' : 'Dark mode',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Semantics(
        button: true,
        label: 'Open navigation menu',
        hint: 'Opens mobile navigation menu',
        child: InkWell(
          onTap: () => _showMobileMenu(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.menu,
              color: widget.isDarkMode ? AppColors.white : AppColors.black,
              size: 24,
              semanticLabel: 'Menu',
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Navigation items in a scrollable list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _navigationItems.length,
                itemBuilder: (context, index) {
                  final item = _navigationItems[index];
                  final isActive = widget.currentSection == item['section'];
                  
                  return Semantics(
                    button: true,
                    label: 'Navigate to ${item['title']} section',
                    selected: isActive,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.gold.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isActive ? Border.all(color: AppColors.gold.withOpacity(0.3)) : null,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onSectionTap(item['section']);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, 
                          vertical: 8,
                        ),
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
                            : Icon(
                                Icons.arrow_forward_ios,
                                color: widget.isDarkMode 
                                    ? AppColors.darkWhite.withOpacity(0.5)
                                    : AppColors.black.withOpacity(0.5),
                                size: 14,
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Bottom padding for safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }
}