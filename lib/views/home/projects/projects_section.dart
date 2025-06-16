import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/projects/project_card.dart';
import 'package:mhk_portfolio_flutter/utils/background_painter.dart';

class ProjectsPage extends StatefulWidget {
  final bool isDarkMode;

  ProjectsPage({super.key, required this.isDarkMode});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  
  final List<String> _filterOptions = [
    'All',
    'Flutter',
    'Mobile App',
    'Web App',
    'Firebase',
    'AI/ML',
  ];

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Custom Social Media App',
      'img': 'assets/projects/socialsd.png',
      'description':
          'Full-stack social media app built with Flutter and Firebase. Features real-time messaging using Firestore, image upload/storage, user authentication, and push notifications. Implements BLoC state management and custom animations for smooth UX.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
      'categories': ['Flutter', 'Mobile App', 'Firebase'],
    },
    {
      'title': 'Rhodaa - Car Renting App',
      'img': 'assets/projects/rhodaa.png',
      'description':
          'P2P car rental platform with Flutter frontend and PHP Laravel backend. Integrated Stripe payments, Google Maps API for location services, real-time GPS tracking, and automated booking system. Features admin dashboard, rating system, and SMS notifications.',
      'appStoreLink': 'https://apps.apple.com/us/app/rhodaa/id1603408711',
      'playStoreLink':
          'https://play.google.com/store/apps/details?id=com.smartcare.zoalcar',
      'githubLink': null,
      'categories': ['Flutter', 'Mobile App', 'Firebase'],
    },
    {
      'title': 'My Expenses Tracker',
      'img': 'assets/projects/expenses.png',
      'description':
          'Personal finance tracker built with Flutter using SQLite for local storage. Implements clean architecture with BLoC pattern, data visualization with charts, category-based expense tracking, and export functionality to CSV/PDF.',
      'appStoreLink': null,
      'playStoreLink':
          'https://play.google.com/store/apps/details?id=com.mhk26.expenses_app',
      'githubLink': 'https://github.com/MHK-26/expenses_tracker',
      'categories': ['Flutter', 'Mobile App'],
    },
    {
      'title': 'AI Bot using Gemini',
      'img': 'assets/projects/app.png',
      'description':
          'AI chatbot app integrating Google Gemini API. Features conversation history with SQLite, markdown rendering for AI responses, typing indicators, error handling with retry logic, and responsive chat UI with message bubbles.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26/flutter_AI_Bot',
      'categories': ['Flutter', 'Mobile App', 'AI/ML'],
    },
    {
      'title': 'ATS Friendly Resume Generator',
      'img': 'assets/projects/resume.png',
      'description':
          'Resume builder with ATS optimization features. Built with Flutter, includes PDF generation using pdf package, template selection, real-time preview, and keyword density analysis. Supports multiple export formats and responsive design.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
      'categories': ['Flutter', 'Mobile App'],
    },
    {
      'title': 'FPL Captain Picker',
      'img': 'assets/projects/fpl.png',
      'description':
          'Fantasy Premier League helper app with captain selection wheel. Integrates FPL official API for live data, implements spin wheel animation, player statistics dashboard, and team comparison features. Built with Flutter and HTTP package.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
      'categories': ['Flutter', 'Mobile App'],
    },
    {
      'title': 'Private Project',
      'img': 'assets/projects/aa.png',
      'description': 'Athlete Arena',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': null,
      'categories': ['Mobile App'],
    },
    {
      'title': 'This website :D',
      'img': 'assets/projects/web.png',
      'description':
          'Personal portfolio website built with Flutter Web. Features responsive design, dark/light theme switching, smooth animations using AnimatedTextKit, and optimized performance. Deployed with GitHub Pages and custom domain setup.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26/mhk_portfolio',
      'categories': ['Flutter', 'Web App'],
    },
  ];

  List<Map<String, dynamic>> get filteredProjects {
    List<Map<String, dynamic>> filtered = projects;

    // Filter by category
    if (_selectedFilter != 'All') {
      filtered = filtered.where((project) {
        List<String> categories = List<String>.from(project['categories'] ?? []);
        return categories.contains(_selectedFilter);
      }).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((project) {
        final title = project['title']?.toLowerCase() ?? '';
        final description = project['description']?.toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: AppColors.gold.withOpacity(0.03),
                isDarkMode: widget.isDarkMode,
              ),
            ),
          ),
          // Main Content
          LayoutBuilder(
            builder: (context, constraints) {
              double horizontalPadding = constraints.maxWidth < 600 ? 16 : 20;
              double fontSize = constraints.maxWidth < 600 ? 28 : 36;
              
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Projects',
                            style: GoogleFonts.inter(
                              color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Explore my featured projects below - each one represents a unique challenge solved with innovation and precision.\nDiscover more on my GitHub for the complete development journey.',
                            style: GoogleFonts.inter(
                              color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                              fontSize: constraints.maxWidth < 600 ? 14 : 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildSearchAndFilter(constraints),
                    const SizedBox(height: 20),
                    buildMobileContent()
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(BoxConstraints constraints) {
    return Column(
      children: [
        // Search Bar
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            style: TextStyle(
              color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Search projects...',
              hintStyle: TextStyle(
                color: widget.isDarkMode 
                    ? AppColors.darkWhite.withOpacity(0.6) 
                    : AppColors.black.withOpacity(0.6),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.gold,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.gold, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              filled: true,
              fillColor: widget.isDarkMode 
                  ? Colors.grey[800]?.withOpacity(0.3) 
                  : Colors.grey[50],
            ),
          ),
        ),
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _filterOptions.map((filter) {
              final isSelected = _selectedFilter == filter;
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white 
                          : widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: constraints.maxWidth < 600 ? 12 : 14,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (bool value) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  selectedColor: AppColors.gold,
                  backgroundColor: widget.isDarkMode 
                      ? Colors.grey[800] 
                      : Colors.grey[200],
                  checkmarkColor: Colors.white,
                  side: BorderSide(
                    color: isSelected 
                        ? AppColors.gold 
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (filteredProjects.isEmpty)
          Container(
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
                  'No projects found',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode 
                        ? AppColors.darkWhite.withOpacity(0.7) 
                        : AppColors.black.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filter criteria',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: widget.isDarkMode 
                        ? AppColors.darkWhite.withOpacity(0.5) 
                        : AppColors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildMobileContent() {
    final filtered = filteredProjects;
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: LayoutBuilder(
        key: ValueKey(filtered.length),
        builder: (context, constraints) {
          // Enhanced responsive grid layout
          if (constraints.maxWidth > 1400) {
            // Large Desktop: 3 columns
            return _buildGridLayout(filtered, 3);
          } else if (constraints.maxWidth > 900) {
            // Desktop/Tablet: 2 columns
            return _buildGridLayout(filtered, 2);
          } else {
            // Mobile: 1 column with enhanced animations
            return _buildEnhancedSingleColumnLayout(filtered);
          }
        },
      ),
    );
  }

  Widget _buildGridLayout(List<Map<String, dynamic>> projects, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.8, // Better proportion for content
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return ProjectCard(
          title: project['title']!,
          img: project['img']!,
          description: project['description']!,
          isDarkMode: widget.isDarkMode,
          appStoreLink: project['appStoreLink'],
          playStoreLink: project['playStoreLink'],
          gitHubLink: project['githubLink'],
        );
      },
    );
  }

  Widget _buildEnhancedSingleColumnLayout(List<Map<String, dynamic>> projects) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;
          
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 150)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(-20 * (1 - value), 30 * (1 - value)),
                child: Transform.scale(
                  scale: 0.9 + (0.1 * value),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: ProjectCard(
                        title: project['title']!,
                        img: project['img']!,
                        description: project['description']!,
                        isDarkMode: widget.isDarkMode,
                        appStoreLink: project['appStoreLink'],
                        playStoreLink: project['playStoreLink'],
                        gitHubLink: project['githubLink'],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
