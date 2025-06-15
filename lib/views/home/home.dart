import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:provider/provider.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/certifications/certifications_section.dart';
import 'package:mhk_portfolio_flutter/views/home/contact_me/contact_me_section.dart';
import 'package:mhk_portfolio_flutter/views/home/footer.dart';
import 'package:mhk_portfolio_flutter/views/home/header_button.dart';
import 'package:mhk_portfolio_flutter/views/home/info/profile_section.dart';
import 'package:mhk_portfolio_flutter/views/home/projects/projects_section.dart';
import 'package:mhk_portfolio_flutter/widgets/skeleton_loader.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GlobalKey> sectionKeys = List.generate(5, (_) => GlobalKey());
  bool _isLoading = true;
  final List<bool> _sectionLoaded = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  void _loadSections() async {
    // Simulate loading profile section
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _sectionLoaded[0] = true;
      });
    }

    // Simulate loading projects section
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _sectionLoaded[1] = true;
      });
    }

    // Simulate loading certifications section
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _sectionLoaded[2] = true;
      });
    }

    // Simulate loading contact section
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _sectionLoaded[3] = true;
        _isLoading = false;
      });
    }
  }

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
            _buildSection(
              0,
              () => ProfileInfoSection(isDarkMode: isDarkMode),
              () => _buildProfileSkeleton(isDarkMode),
            ),
            _buildSection(
              1,
              () => ProjectsPage(isDarkMode: isDarkMode),
              () => _buildProjectsSkeleton(isDarkMode),
            ),
            _buildSection(
              2,
              () => CertificationsSection(isDarkMode: isDarkMode),
              () => _buildCertificationsSkeleton(isDarkMode),
            ),
            _buildSection(
              3,
              () => ContactPage(isDarkMode: isDarkMode),
              () => _buildContactSkeleton(isDarkMode),
            ),
            FooterSection(isDarkMode: isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(int index, Widget Function() content, Widget Function() skeleton) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _sectionLoaded[index] ? content() : skeleton(),
    );
  }

  Widget _buildProfileSkeleton(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          SkeletonLoader(
            width: 150,
            height: 150,
            borderRadius: BorderRadius.circular(75),
          ),
          const SizedBox(height: 20),
          SkeletonLoader(
            width: 200,
            height: 32,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 10),
          SkeletonLoader(
            width: 300,
            height: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSkeleton(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SkeletonLoader(
            width: 200,
            height: 32,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 30),
          ...List.generate(
            3,
            (index) => ProjectCardSkeleton(isDarkMode: isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSkeleton(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SkeletonLoader(
            width: 200,
            height: 32,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 30),
          Wrap(
            children: List.generate(
              6,
              (index) => CertificationCardSkeleton(isDarkMode: isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSkeleton(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          SkeletonLoader(
            width: 200,
            height: 32,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 30),
          SkeletonLoader(
            width: double.infinity,
            height: 300,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}
