import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/projects/project_card.dart';

class ProjectsPage extends StatelessWidget {
  final bool isDarkMode;

  ProjectsPage({super.key, required this.isDarkMode});

  final List<Map<String, String?>> projects = [
    {
      'title': 'Custom Social Media App',
      'img': 'assets/projects/socialsd.png',
      'description':
          'Fully functioning Instagram clone with custom UI, developed using Flutter and Dart, utilizing the Provider State management package and Firebase for the backend.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
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
    },
    {
      'title': 'AI Bot using Gemini',
      'img': 'assets/projects/app.png',
      'description':
          'an AI-powered chat bot that leverages Google\'s Gemini model to provide real-time responses. The app features a user-friendly interface where users can send messages and receive instant replies. It utilizes state management to handle message flows and ensure a smooth user experience. The app also includes error handling and UI feedback to enhance usability.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26/flutter_AI_Bot',
    },
    {
      'title': 'ATS Friendly Resume Generator',
      'img': 'assets/projects/resume.png',
      'description':
          'Generate a fully parsed resume easily and with simple steps. Developed using Flutter, Dart, BLoC State management package, and Sqflite for Database.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
    },
    {
      'title': 'FPL Captain Picker',
      'img': 'assets/projects/fpl.png',
      'description':
          'A Fantasy Premier League Captain Picker App with a lot of features: Wheel of Fortune captain picker, teams view, adding friend teams, previous captains analysis, top 10 captain picks for next Gameweek, etc. Developed using Flutter, Dart, Provider State management package, and Official FPL API.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26',
    },
    {
      'title': 'Private Project',
      'img': 'assets/projects/aa.png',
      'description': 'No information.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': null,
    },
    {
      'title': 'This website :D',
      'img': 'assets/projects/web.png',
      'description':
          'My online portfolio showcasing selected pieces of my work.\nDeveloped using Flutter, Dart. Optimized for web and mobile, and with night mode.',
      'appStoreLink': null,
      'playStoreLink': null,
      'githubLink': 'https://github.com/MHK-26/mhk_portfolio',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                    fontSize: 36,
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
                    color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          buildMobileContent()
        ],
      ),
    );
  }

  Widget buildMobileContent() {
    return Column(
      children: projects.map((project) {
        return ProjectCard(
          title: project['title']!,
          img: project['img']!,
          description: project['description']!,
          isDarkMode: isDarkMode,
          appStoreLink: project['appStoreLink'],
          playStoreLink: project['playStoreLink'],
          gitHubLink: project['githubLink'],
        );
      }).toList(),
    );
  }
}
