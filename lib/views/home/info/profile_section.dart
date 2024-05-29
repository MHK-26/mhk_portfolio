import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/views/home/info/info_section.dart';
import 'package:mhk_portfolio_flutter/views/home/info/profile_card.dart';

class ProfileInfoSection extends StatelessWidget {
  final bool isDarkMode;

  const ProfileInfoSection({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 900;
        return isMobile ? buildMobileContent() : buildWebContent();
      },
    );
  }

  Widget buildMobileContent() {
    return Column(
      children: [
        ProfileCard(isDarkMode: isDarkMode),
        InfoSection(isDarkMode: isDarkMode),
      ],
    );
  }

  Widget buildWebContent() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ProfileCard(isDarkMode: isDarkMode),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InfoSection(isDarkMode: isDarkMode),
          ),
        ),
      ],
    );
  }
}
