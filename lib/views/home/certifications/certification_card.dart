import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationCard extends StatelessWidget {
  final String title;
  final String img;
  final String description;
  final bool isDarkMode;
  final String? certificationLink;

  const CertificationCard({
    super.key,
    required this.title,
    required this.img,
    required this.description,
    required this.isDarkMode,
    this.certificationLink,
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
              // width: double.infinity,
              // height: 200,
              cacheWidth: 500,
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
          Text(
            description,
            style: GoogleFonts.inter(
              color: isDarkMode ? AppColors.darkWhite : AppColors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          _buildLinkButton(context, 'View Certification', certificationLink),
        ],
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String label, String? url) {
    if (url == null) return const SizedBox.shrink();

    return ElevatedButton.icon(
      onPressed: () {
        _launchURL(context, url);
      },
      icon: const Icon(Icons.open_in_new),
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
