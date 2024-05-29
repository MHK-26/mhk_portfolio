import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String img;
  final String description;
  final bool isDarkMode;
  final String? appStoreLink;
  final String? playStoreLink;
  final String? gitHubLink;

  const ProjectCard({
    super.key,
    required this.title,
    required this.img,
    required this.description,
    required this.isDarkMode,
    this.appStoreLink,
    this.playStoreLink,
    this.gitHubLink,
  });

  @override
  Widget build(BuildContext context) {
    return _buildNarrowCard(context);
  }

  Widget _buildNarrowCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.black54, Colors.black87]
              : [Colors.white, Colors.grey[200]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              img,
              fit: BoxFit.contain,
              // width: 600,
              cacheHeight: 600,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 600,
            child: Text(
              description,
              style: GoogleFonts.inter(
                color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLinks(context),
        ],
      ),
    );
  }

  Widget _buildLinks(BuildContext context) {
    List<Widget> links = [];

    if (appStoreLink != null) {
      links.add(_buildLinkButton(
          context, 'App Store', 'assets/icons/apple.png', appStoreLink!));
    }
    if (playStoreLink != null) {
      links.add(_buildLinkButton(
          context, 'Play Store', 'assets/icons/play.png', playStoreLink!));
    }
    if (gitHubLink != null) {
      links.add(_buildLinkButton(
          context, 'GitHub', 'assets/icons/github.png', gitHubLink!));
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: links,
    );
  }

  Widget _buildLinkButton(
      BuildContext context, String label, String iconPath, String url) {
    return ElevatedButton.icon(
      onPressed: () {
        _launchURL(context, url);
      },
      icon: Image.asset(iconPath, width: 20, height: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? AppColors.primary : AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
