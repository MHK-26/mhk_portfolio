import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/colors.dart';
import 'package:mhk_portfolio_flutter/project_card.dart';

class ProjectsPage extends StatelessWidget {
  final bool isDarkMode;

  ProjectsPage({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: isDarkMode
              //         ? [Colors.black87, Colors.black54]
              //         : [Colors.white, Colors.grey[200]!],
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //   ),
              // borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.1),
              //     blurRadius: 10,
              //     offset: Offset(0, 5),
              //   ),
              // ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Projects',
                    style: GoogleFonts.inter(
                      color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '  These are selected projects,\n  you can find my other projects in my github account.',
                    style: GoogleFonts.inter(
                      color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildProjectCard(
              'Custom Social Media App',
              'assets/projects/socialsd.png',
              'Fully functioning Instagram clone with custom UI, Developed using Flutter and Dart, utilizing  the Provider State management package and Firebase for the backend.',
              null,
              null,
              'https://github.com/MHK-26',
            ),
            _buildProjectCard(
              'Rhodaa - Car Renting App',
              'assets/projects/rhodaa.png',
              'Rhodaa is a car rental app that operates on a shared economy model, connecting car owners and renters seamlessly. The app enables car owners to list their vehicles for rent, allowing them to generate income from their idle assets. At the same time, users looking to rent a car can browse through available options, specifying their requirements and comparing prices to find the best match.\n Developed using Flutter, dart, firbase, Laravel, NodeJS',
              'https://apps.apple.com/us/app/rhodaa/id1603408711',
              'https://play.google.com/store/apps/details?id=com.smartcare.zoalcar',
              null,
            ),
            _buildProjectCard(
              'My Expenses Tracker',
              'assets/projects/expenses.png',
              'Personal Expenses Tracker ! Track my Daily Expenses easily. Developed using Flutter, Dart, Bloc State Management Package, Back4App',
              null,
              null,
              'https://github.com/MHK-26',
            ),
            _buildProjectCard(
              'ATS Friendly Resume Genetrator',
              'assets/projects/resume.png',
              'Generate a Fully Parsed Resume easily and with simple steps. Developed using Flutter, Dart, BLoC State management package and Sqflite for Database',
              null,
              null,
              'https://github.com/MHK-26',
            ),
            _buildProjectCard(
              'FPL Captain Picker',
              'assets/projects/fpl.png',
              'A Fantasy premier league Captain Picker App with alot of features,Wheel of fortune captain picker, teams view, adding friend teams, previous captains analysis, top 10 captain picks for next Gameweek...etc. Developed using Flutter, Dart, Provider State management package and Official FPL API',
              null,
              null,
              'https://github.com/MHK-26',
            ),
            _buildProjectCard(
              'Private Project',
              'assets/projects/aa.png',
              'No information.',
              null,
              null,
              null,
            ),
            _buildProjectCard(
              'This website :D',
              'assets/projects/web.png',
              'My Online Portfolio showcasing selected pieces of my work.\n Developed using flutter, Dart. optimized for web and mobile. and with night mode.',
              null,
              null,
              'https://github.com/MHK-26',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(String title, String img, String description,
      String? appStoreLink, String? playStoreLink, String? githubLink) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ProjectCard(
        title: title,
        img: img,
        description: description,
        isDarkMode: isDarkMode,
        appStoreLink: appStoreLink,
        playStoreLink: playStoreLink,
        gitHubLink: githubLink,
      ),
    );
  }
}
