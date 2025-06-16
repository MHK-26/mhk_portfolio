import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/certifications/certification_card.dart';

class CertificationsSection extends StatefulWidget {
  final bool isDarkMode;

  CertificationsSection({super.key, required this.isDarkMode});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> 
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedCategory = 'All';
  
  final List<String> _categories = [
    'All',
    'Cloud & Infrastructure',
    'Product Management',
    'Software Development',
    'Finance & Strategy',
  ];

  final List<Map<String, dynamic>> certifications = [
    {
      'title': 'AWS Certified Solutions Architect – Associate',
      'img': 'assets/certs/awssaa.png',
      'issuer': 'Amazon Web Services',
      'category': 'Cloud & Infrastructure',
      'year': '2024',
      'skills': ['AWS', 'Cloud Architecture', 'Infrastructure'],
      'certificationLink':
          'https://www.credly.com/badges/009e100f-f021-44d1-b3b6-1be5f879a690/linked_in_profile',
    },
    {
      'title': 'GCP Associate Cloud Engineer',
      'img': 'assets/certs/gcpace.png',
      'issuer': 'Google Cloud',
      'category': 'Cloud & Infrastructure',
      'year': '2024',
      'skills': ['Google Cloud', 'DevOps', 'Infrastructure'],
      'certificationLink':
          'https://google.accredible.com/9a459289-0ee5-46da-a9be-47c055d8f2d3',
    },
    {
      'title': 'Professional Scrum Master™ I (PSM I)',
      'img': 'assets/certs/psm.png',
      'issuer': 'scrum.org',
      'category': 'Product Management',
      'year': '2024',
      'skills': ['Scrum', 'Agile', 'Team Leadership'],
      'certificationLink':
          'https://www.credly.com/badges/360621bc-a7e0-473d-b0fa-e2eeb1116910/linked_in_profile',
    },
    {
      'title': 'Software Product Management',
      'img': 'assets/certs/spm.png',
      'issuer': 'University of Alberta',
      'category': 'Product Management',
      'year': '2023',
      'skills': ['Product Strategy', 'User Research', 'Analytics'],
      'certificationLink':
          'https://www.coursera.org/account/accomplishments/specialization/V5AJB7VZADZZ',
    },
    {
      'title': 'McKinsey Forward Program',
      'img': 'assets/certs/mckinsey.png',
      'issuer': 'McKinsey & Company',
      'category': 'Finance & Strategy',
      'year': '2023',
      'skills': ['Strategic Thinking', 'Problem Solving', 'Leadership'],
      'certificationLink':
          'https://www.credly.com/badges/740e7f96-229d-4ce2-a5fe-f9fffe33a441/linked_in_profile',
    },
    {
      'title': 'Product Analytics Micro-Certification (PAC)™',
      'img': 'assets/certs/ps_pa.png',
      'issuer': 'Product School',
      'category': 'Product Management',
      'year': '2023',
      'skills': ['Data Analytics', 'Metrics', 'User Insights'],
      'certificationLink':
          'https://drive.google.com/file/d/1FyioOmI_HqQ8M-5n_nqONJsq6uXT3NAt/view',
    },
    {
      'title': 'Product Strategy Micro-Certification (PSC)™️',
      'img': 'assets/certs/ps_ps.png',
      'issuer': 'Product School',
      'category': 'Product Management',
      'year': '2023',
      'skills': ['Product Strategy', 'Roadmapping', 'Market Analysis'],
      'certificationLink':
          'https://drive.google.com/file/d/1tJ3ADSnf_Zqp9t5F-mT5EqJiDx9mQCuo/view',
    },
    {
      'title': 'Certificate in Digital Money (CIDM)',
      'img': 'assets/certs/cidm.png',
      'issuer': 'Digital Frontiers Institute',
      'category': 'Finance & Strategy',
      'year': '2022',
      'skills': ['Fintech', 'Digital Banking', 'Cryptocurrency'],
      'certificationLink':
          'https://app.diplomasafe.com/en-US/diploma/d5bc0c2164503b2ec7ad4e5c366e69154fb9472eb',
    },
    {
      'title': 'Leading Digital Money Markets (LDMM)',
      'img': 'assets/certs/ldmm.png',
      'issuer': 'Digital Frontiers Institute',
      'category': 'Finance & Strategy',
      'year': '2022',
      'skills': ['Financial Markets', 'Digital Transformation', 'Innovation'],
      'certificationLink':
          'https://app.diplomasafe.com/en-US/diploma/dcd9f2704d7a7993744dd7d26ac3c0bc88018e52c',
    },
    {
      'title': 'Software Architecture Foundation',
      'img': 'assets/certs/linkedin_sa.png',
      'issuer': 'LinkedIn Learning',
      'category': 'Software Development',
      'year': '2022',
      'skills': ['Software Architecture', 'System Design', 'Best Practices'],
      'certificationLink': 'https://www.linkedin.com/in/mhk26/',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredCertifications {
    if (_selectedCategory == 'All') {
      return certifications;
    }
    return certifications.where((cert) => cert['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double horizontalPadding = constraints.maxWidth < 600 ? 16 : 20;
        double titleFontSize = constraints.maxWidth < 600 ? 28 : 36;
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(titleFontSize),
              const SizedBox(height: 30),
              
              // Category Filter
              _buildCategoryFilter(constraints),
              const SizedBox(height: 40),
              
              // Statistics Cards
              _buildStatisticsCards(),
              const SizedBox(height: 40),
              
              // Certifications Grid
              _buildCertificationsGrid(constraints),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(double fontSize) {
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
                Icons.military_tech,
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
                    'Professional Certifications',
                    style: GoogleFonts.poppins(
                      color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Continuous learning across cloud, product management, and software development',
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
      ],
    );
  }

  Widget _buildCategoryFilter(BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by Category',
          style: GoogleFonts.inter(
            color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              final count = category == 'All' 
                  ? certifications.length 
                  : certifications.where((cert) => cert['category'] == category).length;
              
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                            )
                          : null,
                      color: isSelected 
                          ? null 
                          : widget.isDarkMode 
                              ? Colors.grey[800] 
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.gold 
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category,
                          style: GoogleFonts.inter(
                            color: isSelected 
                                ? Colors.white
                                : widget.isDarkMode 
                                    ? AppColors.darkWhite 
                                    : AppColors.black,
                            fontSize: constraints.maxWidth < 600 ? 12 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.white.withOpacity(0.2)
                                : AppColors.gold.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCards() {
    final totalCerts = certifications.length;
    final categories = certifications.map((cert) => cert['category']).toSet().length;
    final recentCerts = certifications.where((cert) => 
        int.parse(cert['year']!) >= DateTime.now().year - 1).length;

    return Row(
      children: [
        Expanded(child: _buildStatCard('Total Certifications', totalCerts.toString(), Icons.verified)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Categories', categories.toString(), Icons.category)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Recent (2024)', recentCerts.toString(), Icons.new_releases)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            color: AppColors.gold.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.gold,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: widget.isDarkMode 
                  ? AppColors.darkWhite.withOpacity(0.8)
                  : AppColors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsGrid(BoxConstraints constraints) {
    final filtered = filteredCertifications;
    
    if (filtered.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: widget.isDarkMode 
                  ? AppColors.darkWhite.withOpacity(0.5)
                  : AppColors.black.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No certifications found',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.isDarkMode 
                    ? AppColors.darkWhite.withOpacity(0.7)
                    : AppColors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    // Enhanced responsive grid with better breakpoints
    if (constraints.maxWidth > 1400) {
      return _buildEnhancedGridView(filtered, 4); // Large desktop: 4 columns
    } else if (constraints.maxWidth > 1000) {
      return _buildEnhancedGridView(filtered, 3); // Desktop: 3 columns
    } else if (constraints.maxWidth > 700) {
      return _buildEnhancedGridView(filtered, 2); // Tablet: 2 columns
    } else {
      return _buildEnhancedSingleColumnView(filtered); // Mobile: 1 column
    }
  }

  Widget _buildEnhancedGridView(List<Map<String, dynamic>> certs, int crossAxisCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: crossAxisCount == 4 ? 0.85 : 0.8, // Better ratio for 4 columns
        ),
        itemCount: certs.length,
        itemBuilder: (context, index) {
          return _buildEnhancedAnimatedCertCard(certs[index], index);
        },
      ),
    );
  }

  Widget _buildEnhancedSingleColumnView(List<Map<String, dynamic>> certs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: certs.asMap().entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: _buildEnhancedAnimatedCertCard(entry.value, entry.key),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEnhancedAnimatedCertCard(Map<String, dynamic> cert, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 120)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-15 * (1 - value), 40 * (1 - value)),
          child: Transform.scale(
            scale: 0.9 + (0.1 * value),
            child: Opacity(
              opacity: value,
              child: CertificationCard(
                title: cert['title']!,
                img: cert['img']!,
                issuer: cert['issuer']!,
                category: cert['category']!,
                year: cert['year']!,
                skills: List<String>.from(cert['skills']!),
                isDarkMode: widget.isDarkMode,
                certificationLink: cert['certificationLink'],
              ),
            ),
          ),
        );
      },
    );
  }
}
