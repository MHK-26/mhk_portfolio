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
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isDarkMode
                ? [Colors.grey[850]!, Colors.grey[800]!]
                : [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingSection(),
            const SizedBox(height: 30),
            _buildAboutSection(),
            const SizedBox(height: 30),
            _buildExperienceCards(),
            const SizedBox(height: 30),
            _buildTechStackSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                fontSize: 32,
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
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.isDarkMode 
            ? Colors.black.withOpacity(0.2)
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rocket_launch,
                color: AppColors.gold,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                fontSize: 14,
                height: 1.5,
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
        ],
      ),
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
