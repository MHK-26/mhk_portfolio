import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  final bool isDarkMode;

  const SocialLinks({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIcon(
          assetPath: 'assets/icons/linkedin.png',
          url: 'https://www.linkedin.com/in/mhk26',
        ),
        const SizedBox(width: 20),
        SocialIcon(
          assetPath: 'assets/icons/github.png',
          url: 'https://github.com/MHK-26',
        ),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String assetPath;
  final String url;

  SocialIcon({required this.assetPath, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Image.asset(assetPath, width: 35, height: 35),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
