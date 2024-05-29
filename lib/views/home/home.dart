import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:provider/provider.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/certifications/certifications_section.dart';
import 'package:mhk_portfolio_flutter/views/home/footer.dart';
import 'package:mhk_portfolio_flutter/views/home/header_button.dart';
import 'package:mhk_portfolio_flutter/views/home/info/profile_section.dart';
import 'package:mhk_portfolio_flutter/views/home/projects/projects_section.dart';

class HomeScreen extends StatelessWidget {
  final List<GlobalKey> sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.background,
      appBar: MyAppBar(
        isDarkMode: isDarkMode,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileInfoSection(isDarkMode: isDarkMode),
            ProjectsPage(isDarkMode: isDarkMode),
            CertificationsSection(isDarkMode: isDarkMode),
            FooterSection(isDarkMode: isDarkMode),
          ],
        ),
      ),
    );
  }
}
