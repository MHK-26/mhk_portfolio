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
    // Simulate loading time for awesome effect
    await Future.delayed(const Duration(milliseconds: 2500));
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
        child: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: GridPatternPainter(
                  color: AppColors.gold.withOpacity(0.03),
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
            
            // Main Loading Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo with Pulse Effect
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        width: 100 + (20 * value),
                        height: 100 + (20 * value),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              AppColors.gold,
                              AppColors.gold.withOpacity(0.8),
                              AppColors.gold.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25 + (5 * value)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withOpacity(0.4 * value),
                              blurRadius: 30 + (20 * value),
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: AppColors.gold.withOpacity(0.2 * value),
                              blurRadius: 60 + (40 * value),
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'MH',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 36 + (8 * value),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Animated Welcome Text
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 2000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: Column(
                            children: [
                              Text(
                                'Mohammad Hisham',
                                style: GoogleFonts.poppins(
                                  color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Senior Software Engineer',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Loading Progress
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 2500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Container(
                            width: 200,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: value,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gold.withOpacity(0.5),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Loading Portfolio... ${(value * 100).toInt()}%',
                            style: GoogleFonts.inter(
                              color: isDarkMode 
                                  ? AppColors.darkWhite.withOpacity(0.8)
                                  : AppColors.black.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPatternPainter extends CustomPainter {
  final Color color;
  final bool isDarkMode;

  GridPatternPainter({required this.color, required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const spacing = 50.0;
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
