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

  CertificationCard({
    required this.title,
    required this.img,
    required this.description,
    required this.isDarkMode,
    this.certificationLink,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return _buildWideCard(context);
        } else {
          return _buildNarrowCard(context);
        }
      },
    );
  }

  Widget _buildWideCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                img,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                _buildLinkButton(
                    context, 'View Certification', certificationLink),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
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
              width: double.infinity,
              height: 200,
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.inter(
              color: isDarkMode ? AppColors.darkWhite : AppColors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          _buildLinkButton(context, 'View Certification', certificationLink),
        ],
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String label, String? url) {
    if (url == null) return SizedBox.shrink();

    return ElevatedButton.icon(
      onPressed: () {
        _launchURL(context, url);
      },
      icon: Icon(Icons.open_in_new),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? AppColors.primary : AppColors.primary,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
