import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  final bool isDarkMode;

  const ContactSection({super.key, required this.isDarkMode});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _contactMethods = [
    {
      'title': 'Email',
      'subtitle': 'mzoom26@hotmail.com',
      'icon': Icons.email,
      'color': Colors.red,
      'action': 'mailto:mzoom26@hotmail.com',
    },
    {
      'title': 'LinkedIn',
      'subtitle': '/in/mhk26',
      'icon': Icons.work,
      'color': Colors.blue,
      'action': 'https://linkedin.com/in/mhk26',
    },
    {
      'title': 'GitHub',
      'subtitle': '/MHK-26',
      'icon': Icons.code,
      'color': Colors.grey[800]!,
      'action': 'https://github.com/MHK-26',
    },
    {
      'title': 'Phone',
      'subtitle': 'Available on request',
      'icon': Icons.phone,
      'color': Colors.green,
      'action': null,
    },
  ];

  final List<Map<String, dynamic>> _quickLinks = [
    {'title': 'About', 'section': 'about'},
    {'title': 'Experience', 'section': 'experience'},
    {'title': 'Projects', 'section': 'projects'},
    {'title': 'Certifications', 'section': 'certifications'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: widget.isDarkMode
              ? [Colors.grey[900]!, Colors.black]
              : [Colors.grey[50]!, Colors.white],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          
          return Column(
            children: [
              _buildContactSection(isMobile),
              _buildFooter(isMobile),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContactSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildHeader(isMobile),
          const SizedBox(height: 60),
          if (isMobile)
            _buildMobileLayout()
          else
            _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.connect_without_contact,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Let\'s Work Together',
                  style: GoogleFonts.poppins(
                    color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  constraints: BoxConstraints(maxWidth: isMobile ? 300 : 500),
                  child: Text(
                    'Ready to bring your ideas to life? I\'d love to hear about your project and discuss how we can work together.',
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.8)
                          : AppColors.black.withOpacity(0.7),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildContactMethods(),
        ),
        const SizedBox(width: 60),
        Expanded(
          child: _buildQuickActions(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContactMethods(),
        const SizedBox(height: 40),
        _buildQuickActions(),
      ],
    );
  }

  Widget _buildContactMethods() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get In Touch',
                  style: GoogleFonts.poppins(
                    color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ..._contactMethods.asMap().entries.map((entry) {
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 600 + (entry.key * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: _buildContactCard(entry.value),
                        ),
                      );
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: contact['action'] != null 
            ? () => _launchURL(contact['action'])
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isDarkMode
                  ? [Colors.grey[850]!, Colors.grey[800]!]
                  : [Colors.white, Colors.grey[50]!],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.gold.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: contact['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  contact['icon'],
                  color: contact['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact['title'],
                      style: GoogleFonts.inter(
                        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contact['subtitle'],
                      style: GoogleFonts.inter(
                        color: widget.isDarkMode 
                            ? AppColors.darkWhite.withOpacity(0.7)
                            : AppColors.black.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (contact['action'] != null)
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.gold,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.1),
                    AppColors.gold.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Links',
                    style: GoogleFonts.poppins(
                      color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._quickLinks.map((link) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          // TODO: Implement section navigation
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: AppColors.gold,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              link['title'],
                              style: GoogleFonts.inter(
                                color: widget.isDarkMode 
                                    ? AppColors.darkWhite.withOpacity(0.8)
                                    : AppColors.black.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL('mailto:mzoom26@hotmail.com'),
                      icon: const Icon(Icons.send, size: 18),
                      label: const Text('Send Message'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.gold.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          if (isMobile)
            _buildMobileFooter()
          else
            _buildDesktopFooter(),
          const SizedBox(height: 20),
          Divider(
            color: AppColors.gold.withOpacity(0.2),
          ),
          const SizedBox(height: 20),
          Text(
            '© 2024 Mohammad Hisham. Built with Flutter 💙',
            style: GoogleFonts.inter(
              color: widget.isDarkMode 
                  ? AppColors.darkWhite.withOpacity(0.6)
                  : AppColors.black.withOpacity(0.5),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mohammad Hisham',
              style: GoogleFonts.poppins(
                color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Senior Software Engineer',
              style: GoogleFonts.inter(
                color: AppColors.gold,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          'Always open to interesting opportunities',
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.7)
                : AppColors.black.withOpacity(0.6),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        Text(
          'Mohammad Hisham',
          style: GoogleFonts.poppins(
            color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Senior Software Engineer',
          style: GoogleFonts.inter(
            color: AppColors.gold,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Always open to interesting opportunities',
          style: GoogleFonts.inter(
            color: widget.isDarkMode 
                ? AppColors.darkWhite.withOpacity(0.7)
                : AppColors.black.withOpacity(0.6),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      // Handle error silently
    }
  }
}