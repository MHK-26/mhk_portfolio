import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:provider/provider.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/hero/hero_section.dart';
import 'package:mhk_portfolio_flutter/views/home/navigation/navigation_bar.dart';
import 'package:mhk_portfolio_flutter/views/home/info/profile_section.dart';
import 'package:mhk_portfolio_flutter/views/home/experience/experience_section.dart';
import 'package:mhk_portfolio_flutter/views/home/projects/projects_section.dart';
import 'package:mhk_portfolio_flutter/views/home/certifications/certifications_section.dart';
import 'package:mhk_portfolio_flutter/views/home/contact/contact_section.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _currentSection = 'hero';
  
  final Map<String, GlobalKey> _sectionKeys = {
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'certifications': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.offset;
    String newSection = 'hero';
    
    _sectionKeys.forEach((section, key) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 100 && position.dy + box.size.height > 100) {
            newSection = section;
          }
        }
      }
    });
    
    if (newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
      });
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.background,
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                Container(
                  key: _sectionKeys['hero'],
                  child: HeroSection(isDarkMode: isDarkMode),
                ),
                
                // About Section
                Container(
                  key: _sectionKeys['about'],
                  child: ProfileInfoSection(isDarkMode: isDarkMode),
                ),
                
                _buildSectionDivider(isDarkMode),
                
                // Experience Section
                Container(
                  key: _sectionKeys['experience'],
                  child: ExperienceSection(isDarkMode: isDarkMode),
                ),
                
                _buildSectionDivider(isDarkMode),
                
                // Projects Section
                Container(
                  key: _sectionKeys['projects'],
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: ProjectsPage(isDarkMode: isDarkMode),
                ),
                
                _buildSectionDivider(isDarkMode),
                
                // Certifications Section
                Container(
                  key: _sectionKeys['certifications'],
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: CertificationsSection(isDarkMode: isDarkMode),
                ),
                
                _buildSectionDivider(isDarkMode),
                
                // Contact Section
                Container(
                  key: _sectionKeys['contact'],
                  child: ContactSection(isDarkMode: isDarkMode),
                ),
              ],
            ),
          ),
          
          // Sticky Navigation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(
              isDarkMode: isDarkMode,
              onThemeToggle: () => themeProvider.toggleTheme(),
              onSectionTap: _scrollToSection,
              currentSection: _currentSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionDivider(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: Divider(
        height: 1,
        thickness: 1,
        color: isDarkMode 
            ? AppColors.gold.withOpacity(0.1)
            : AppColors.gold.withOpacity(0.2),
      ),
    );
  }
}
