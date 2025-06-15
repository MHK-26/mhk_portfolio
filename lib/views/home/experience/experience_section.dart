import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class ExperienceSection extends StatefulWidget {
  final bool isDarkMode;

  const ExperienceSection({super.key, required this.isDarkMode});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> experiences = [
    {
      'title': 'Senior Software Engineer',
      'company': 'Tech Innovation Corp',
      'period': '2022 - Present',
      'type': 'Full-time',
      'description': 'Led development of microservices architecture serving 1M+ users. Implemented CI/CD pipelines reducing deployment time by 70%.',
      'technologies': ['Flutter', 'AWS', 'Python', 'Docker', 'Kubernetes'],
      'achievements': [
        'Reduced system latency by 40%',
        'Led team of 5 developers',
        'Designed scalable architecture',
      ],
      'icon': Icons.engineering,
      'color': AppColors.gold,
    },
    {
      'title': 'Full Stack Developer',
      'company': 'Digital Solutions Ltd',
      'period': '2020 - 2022',
      'type': 'Full-time',
      'description': 'Developed and maintained web applications using modern frameworks. Collaborated with cross-functional teams to deliver high-quality software.',
      'technologies': ['Laravel', 'Vue.js', 'MySQL', 'GCP', 'PHP'],
      'achievements': [
        'Built 10+ production applications',
        'Improved code coverage to 85%',
        'Mentored junior developers',
      ],
      'icon': Icons.web,
      'color': Colors.blue,
    },
    {
      'title': 'Software Developer',
      'company': 'StartupTech Inc',
      'period': '2018 - 2020',
      'type': 'Full-time',
      'description': 'Built mobile applications and APIs from scratch. Worked in an agile environment with rapid iteration cycles.',
      'technologies': ['Java', 'Android', 'Spring Boot', 'MySQL'],
      'achievements': [
        'Launched 3 mobile apps',
        'Achieved 4.8+ app store rating',
        'Optimized database performance',
      ],
      'icon': Icons.phone_android,
      'color': Colors.green,
    },
    {
      'title': 'Junior Developer',
      'company': 'Code Academy',
      'period': '2017 - 2018',
      'type': 'Full-time',
      'description': 'Started career in software development, learned industry best practices and contributed to various projects.',
      'technologies': ['JavaScript', 'HTML/CSS', 'Node.js', 'MongoDB'],
      'achievements': [
        'Completed 15+ projects',
        'Learned 5 programming languages',
        'Received excellence award',
      ],
      'icon': Icons.school,
      'color': Colors.purple,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: widget.isDarkMode 
            ? Colors.grey[900]
            : Colors.grey[50],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          double horizontalPadding = isMobile ? 20 : 60;
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isMobile),
                const SizedBox(height: 60),
                _buildTimeline(isMobile),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                Icons.timeline,
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
                    'Professional Experience',
                    style: GoogleFonts.poppins(
                      color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'My journey in software development and the impact I\'ve made',
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.8)
                          : AppColors.black.withOpacity(0.7),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeline(bool isMobile) {
    if (isMobile) {
      return Column(
        children: experiences.asMap().entries.map((entry) {
          return _buildMobileExperienceCard(entry.value, entry.key);
        }).toList(),
      );
    } else {
      return _buildDesktopTimeline();
    }
  }

  Widget _buildDesktopTimeline() {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final experience = entry.value;
        final index = entry.key;
        final isEven = index % 2 == 0;
        
        return _buildTimelineItem(experience, index, isEven);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> experience, int index, bool isLeft) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value) * (isLeft ? -1 : 1), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Row(
                children: [
                  // Left content (for even indices) or spacer
                  Expanded(
                    child: isLeft 
                        ? _buildExperienceCard(experience, true)
                        : const SizedBox(),
                  ),
                  
                  // Timeline center
                  _buildTimelineCenter(experience),
                  
                  // Right content (for odd indices) or spacer
                  Expanded(
                    child: !isLeft 
                        ? _buildExperienceCard(experience, false)
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimelineCenter(Map<String, dynamic> experience) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  experience['color'],
                  experience['color'].withOpacity(0.8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: experience['color'].withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              experience['icon'],
              color: Colors.white,
              size: 24,
            ),
          ),
          Container(
            width: 2,
            height: 60,
            color: AppColors.gold.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience, bool isLeft) {
    return Container(
      margin: EdgeInsets.only(
        left: isLeft ? 0 : 20,
        right: isLeft ? 20 : 0,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.isDarkMode
              ? [Colors.grey[850]!, Colors.grey[800]!]
              : [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(experience),
          const SizedBox(height: 16),
          _buildCardDescription(experience),
          const SizedBox(height: 16),
          _buildTechnologies(experience),
          const SizedBox(height: 16),
          _buildAchievements(experience),
        ],
      ),
    );
  }

  Widget _buildMobileExperienceCard(Map<String, dynamic> experience, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline indicator
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              experience['color'],
                              experience['color'].withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Icon(
                          experience['icon'],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (index < experiences.length - 1)
                        Container(
                          width: 2,
                          height: 80,
                          color: AppColors.gold.withOpacity(0.3),
                        ),
                    ],
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: widget.isDarkMode
                              ? [Colors.grey[850]!, Colors.grey[800]!]
                              : [Colors.white, Colors.grey[50]!],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.gold.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardHeader(experience),
                          const SizedBox(height: 12),
                          _buildCardDescription(experience),
                          const SizedBox(height: 12),
                          _buildTechnologies(experience),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardHeader(Map<String, dynamic> experience) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                experience['title'],
                style: GoogleFonts.poppins(
                  color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: experience['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: experience['color'].withOpacity(0.3),
                ),
              ),
              child: Text(
                experience['type'],
                style: GoogleFonts.inter(
                  color: experience['color'],
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          experience['company'],
          style: GoogleFonts.inter(
            color: AppColors.gold,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          experience['period'],
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.7)
                : AppColors.black.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCardDescription(Map<String, dynamic> experience) {
    return Text(
      experience['description'],
      style: GoogleFonts.inter(
        color: widget.isDarkMode 
            ? AppColors.darkWhite.withOpacity(0.8)
            : AppColors.black.withOpacity(0.7),
        fontSize: 14,
        height: 1.5,
      ),
    );
  }

  Widget _buildTechnologies(Map<String, dynamic> experience) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: (experience['technologies'] as List<String>).map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            tech,
            style: GoogleFonts.inter(
              color: AppColors.gold,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAchievements(Map<String, dynamic> experience) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Achievements:',
          style: GoogleFonts.inter(
            color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...(experience['achievements'] as List<String>).map((achievement) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    achievement,
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.7)
                          : AppColors.black.withOpacity(0.6),
                      fontSize: 11,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}