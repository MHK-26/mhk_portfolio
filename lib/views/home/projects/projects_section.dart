import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/projects/project_card.dart';

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
          'Fully functioning Instagram clone with custom UI, developed using Flutter and Dart, utilizing the Provider State management package and Firebase for the backend.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
      'categories': ['Flutter', 'Mobile App', 'Firebase'],
    },
    {
      'title': 'Rhodaa - Car Renting App',
      'img': 'assets/projects/rhodaa.png',
      'description':
          'Rhodaa is a car rental app that operates on a shared economy model, connecting car owners and renters seamlessly. The app enables car owners to list their vehicles for rent, allowing them to generate income from their idle assets. At the same time, users looking to rent a car can browse through available options, specifying their requirements and comparing prices to find the best match.\nDeveloped using Flutter, Dart, Firebase, Laravel, NodeJS.',
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
          'Personal Expenses Tracker! Track my daily expenses easily. Developed using Flutter, Dart, Bloc State Management Package, Sqflite DB.',
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
          'an AI-powered chat bot that leverages Google\'s Gemini model to provide real-time responses. The app features a user-friendly interface where users can send messages and receive instant replies. It utilizes state management to handle message flows and ensure a smooth user experience. The app also includes error handling and UI feedback to enhance usability.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26/flutter_AI_Bot',
      'categories': ['Flutter', 'Mobile App', 'AI/ML'],
    },
    {
      'title': 'ATS Friendly Resume Generator',
      'img': 'assets/projects/resume.png',
      'description':
          'Generate a fully parsed resume easily and with simple steps. Developed using Flutter, Dart, BLoC State management package, and Sqflite for Database.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
      'categories': ['Flutter', 'Mobile App'],
    },
    {
      'title': 'FPL Captain Picker',
      'img': 'assets/projects/fpl.png',
      'description':
          'A Fantasy Premier League Captain Picker App with a lot of features: Wheel of Fortune captain picker, teams view, adding friend teams, previous captains analysis, top 10 captain picks for next Gameweek, etc. Developed using Flutter, Dart, Provider State management package, and Official FPL API.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
      'categories': ['Flutter', 'Mobile App'],
    },
    {
      'title': 'Private Project',
      'img': 'assets/projects/aa.png',
      'description': 'No information.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': null,
      'categories': ['Mobile App'],
    },
    {
      'title': 'This website :D',
      'img': 'assets/projects/web.png',
      'description':
          'My online portfolio showcasing selected pieces of my work.\nDeveloped using Flutter, Dart. Optimized for web and mobile, and with night mode.',
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
    return LayoutBuilder(
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
                      'These are selected projects,\nYou can find my other projects on my GitHub account.',
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
          // Responsive grid layout
          if (constraints.maxWidth > 1200) {
            // Desktop: 2 columns
            return _buildGridLayout(filtered, 2);
          } else if (constraints.maxWidth > 800) {
            // Tablet: 2 columns but smaller
            return _buildGridLayout(filtered, 2);
          } else {
            // Mobile: 1 column
            return _buildSingleColumnLayout(filtered);
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
        childAspectRatio: 0.75, // Adjust based on content
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

  Widget _buildSingleColumnLayout(List<Map<String, dynamic>> projects) {
    return Column(
      children: projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;
        
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
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
            );
          },
        );
      }).toList(),
    );
  }
}
