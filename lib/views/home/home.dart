import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:provider/provider.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/hero/hero_section.dart';
import 'package:mhk_portfolio_flutter/views/home/info/info_section.dart';
import 'package:mhk_portfolio_flutter/views/home/navigation/navigation_bar.dart';
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
  bool _isLoading = true;
  
  final Map<String, GlobalKey> _sectionKeys = {
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'projects': GlobalKey(),
    'certifications': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _initializeApp();
  }

  void _initializeApp() async {
    // Simulate loading time
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _sectionKeys.forEach((section, key) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 100 && position.dy + box.size.height > 100) {
            if (_currentSection != section) {
              setState(() {
                _currentSection = section;
              });
            }
          }
        }
      }
    });
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

    if (_isLoading) {
      return _buildLoadingScreen(isDarkMode);
    }

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Add padding for navbar
                const SizedBox(height: 80),
                
                // Hero and Profile Section (Same Height)
                Container(
                  key: _sectionKeys['hero'],
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile = constraints.maxWidth < 768;
                      
                      if (isMobile) {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: HeroSection(isDarkMode: isDarkMode),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: InfoSection(isDarkMode: isDarkMode),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              // Hero Section
                              Expanded(
                                child: HeroSection(isDarkMode: isDarkMode),
                              ),
                              
                              // Info Section
                              Expanded(
                                child: InfoSection(isDarkMode: isDarkMode),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
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

  Widget _buildLoadingScreen(bool isDarkMode) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Colors.black, Colors.grey[900]!, Colors.black]
                : [Colors.white, Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 24),
              
              // Loading text
              Text(
                'Loading Portfolio...',
                style: GoogleFonts.inter(
                  color: isDarkMode 
                      ? AppColors.darkWhite.withOpacity(0.8)
                      : AppColors.black.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
