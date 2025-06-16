import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class InfoSection extends StatefulWidget {
  final bool isDarkMode;

  const InfoSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> 
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDarkMode
              ? [
                  Colors.black,
                  Colors.grey[900]!,
                  Colors.black,
                ]
              : [
                  Colors.white,
                  Colors.grey[50]!,
                  Colors.white,
                ],
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern
          _buildBackgroundPattern(),
          
          // Main Content
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 768;
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAboutHeader(isMobile),
                          SizedBox(height: isMobile ? 30 : 40),
                          _buildAboutDescription(isMobile),
                          SizedBox(height: isMobile ? 30 : 40),
                          _buildExperienceCards(),
                          SizedBox(height: isMobile ? 30 : 40),
                          _buildTechStackSection(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: CustomPaint(
        painter: GridPatternPainter(
          color: AppColors.gold.withOpacity(0.05),
          isDarkMode: widget.isDarkMode,
        ),
      ),
    );
  }

  Widget _buildAboutHeader(bool isMobile) {
    return Column(
      children: [
        Text(
          'About Me',
          style: GoogleFonts.poppins(
            color: widget.isDarkMode ? AppColors.white : AppColors.black,
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Passionate Software Engineer',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: isMobile ? 14 : 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutDescription(bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 400 : 600),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.8)
                : AppColors.black.withOpacity(0.7),
            fontSize: isMobile ? 16 : 18,
            height: 1.6,
          ),
          children: [
            const TextSpan(text: 'I\'m a Software Engineer with '),
            TextSpan(
              text: '7+ years',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
              ),
            ),
            const TextSpan(text: ' of hands-on experience specializing in '),
            TextSpan(
              text: 'full-stack development, cloud architecture, and mobile applications',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.gold,
              ),
            ),
            const TextSpan(text: '. I\'m passionate about creating scalable solutions and bringing ideas to life through code.'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.gold.withOpacity(0.4),
                AppColors.gold.withOpacity(0.1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(6),
            child: const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/imgs/pp.jpeg'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Mohammad Hisham',
          style: GoogleFonts.poppins(
            color: widget.isDarkMode ? AppColors.white : AppColors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Senior Software Engineer',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.waving_hand,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Hello There!',
              style: GoogleFonts.poppins(
                color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m a passionate software engineer who loves building innovative solutions that make a difference.',
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.9)
                : AppColors.black.withOpacity(0.8),
            fontSize: 16,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: GoogleFonts.poppins(
                      color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Software Engineer passionate about innovation',
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.8)
                          : AppColors.black.withOpacity(0.7),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Content
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: widget.isDarkMode 
                ? Colors.black.withOpacity(0.2)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.gold.withOpacity(0.1),
            ),
          ),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                fontSize: 16,
                height: 1.6,
              ),
              children: [
                const TextSpan(text: 'I\'m a Software Engineer with '),
                TextSpan(
                  text: '7+ years',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.gold,
                  ),
                ),
                const TextSpan(text: ' of hands-on experience specializing in '),
                TextSpan(
                  text: 'full-stack development, cloud architecture, and mobile applications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gold,
                  ),
                ),
                const TextSpan(text: '. I\'m passionate about creating scalable solutions and bringing ideas to life through code.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCards() {
    final experiences = [
      {
        'icon': Icons.code,
        'title': 'Backend Development',
        'skills': 'PHP • Laravel • Python • Java • APIs',
      },
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Development',
        'skills': 'Flutter • Dart • iOS • Android',
      },
      {
        'icon': Icons.cloud,
        'title': 'Cloud & DevOps',
        'skills': 'AWS • GCP • Microservices • Docker',
      },
      {
        'icon': Icons.manage_accounts,
        'title': 'Product Management',
        'skills': 'Agile • Scrum • JIRA • Strategy',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expertise Areas',
          style: GoogleFonts.poppins(
            color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final exp = experiences[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.1),
                    AppColors.gold.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        exp['icon'] as IconData,
                        color: AppColors.gold,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          exp['title'] as String,
                          style: GoogleFonts.inter(
                            color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exp['skills'] as String,
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.7)
                          : AppColors.black.withOpacity(0.6),
                      fontSize: 10,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTechStackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.integration_instructions,
              color: AppColors.gold,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Tech Stack',
              style: GoogleFonts.poppins(
                color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTechStackIcons(),
      ],
    );
  }


  Wrap _buildTechStackIcons() {
    const iconSize = 35.0;
    const iconPaths = [
      'assets/icons/flutter.png',
      'assets/icons/dart.png',
      'assets/icons/java.png',
      'assets/icons/php.png',
      'assets/icons/laravel.png',
      'assets/icons/html.png',
      'assets/icons/python.png',
      'assets/icons/gcp.png',
      'assets/icons/aws.png',
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: iconPaths
          .map((path) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(path, width: iconSize, height: iconSize),
              ))
          .toList(),
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
