import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/home/certifications/certification_card.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class CertificationsSection extends StatelessWidget {
  final bool isDarkMode;

  CertificationsSection({required this.isDarkMode});

  final List<Map<String, String>> certifications = [
    {
      'title': 'Professional Scrum Master™ I (PSM I)',
      'img': 'assets/certs/psm.png',
      'description': 'scrum.org',
      'certificationLink':
          'https://www.credly.com/badges/360621bc-a7e0-473d-b0fa-e2eeb1116910/linked_in_profile',
    },
    {
      'title': 'AWS Certified Solutions Architect – Associate',
      'img': 'assets/certs/awssaa.png',
      'description': 'Amazon Web SErvices',
      'certificationLink':
          'https://www.credly.com/badges/009e100f-f021-44d1-b3b6-1be5f879a690/linked_in_profile',
    },
    {
      'title': 'GCP Associate Cloud Engineer',
      'img': 'assets/certs/gcpace.png',
      'description': 'Google Cloud',
      'certificationLink':
          'https://google.accredible.com/9a459289-0ee5-46da-a9be-47c055d8f2d3',
    },
    {
      'title': 'Software Product Management',
      'img': 'assets/certs/spm.png',
      'description': 'University of Alberta',
      'certificationLink':
          'https://www.coursera.org/account/accomplishments/specialization/V5AJB7VZADZZ',
    },
    {
      'title': 'McKinsey Forward Program',
      'img': 'assets/certs/mckinsey.png',
      'description': 'McKinsey & Company',
      'certificationLink':
          'https://www.credly.com/badges/740e7f96-229d-4ce2-a5fe-f9fffe33a441/linked_in_profile',
    },
    {
      'title': 'Product Analytics Micro-Certification (PAC)™',
      'img': 'assets/certs/ps_pa.png',
      'description': 'Product School',
      'certificationLink':
          'https://drive.google.com/file/d/1FyioOmI_HqQ8M-5n_nqONJsq6uXT3NAt/view',
    },
    {
      'title': 'Product Strategy Micro-Certification (PSC)™️',
      'img': 'assets/certs/ps_ps.png',
      'description': 'Product School',
      'certificationLink':
          'https://drive.google.com/file/d/1tJ3ADSnf_Zqp9t5F-mT5EqJiDx9mQCuo/view',
    },
    {
      'title': 'Certificate in Digital Money (CIDM)',
      'img': 'assets/certs/cidm.png',
      'description': 'Digital Frontiers Institute & The Fletcher School',
      'certificationLink':
          'https://app.diplomasafe.com/en-US/diploma/d5bc0c2164503b2ec7ad4e5c366e69154fb9472eb',
    },
    {
      'title': 'Leading Digital Money Markets (LDMM)',
      'img': 'assets/certs/ldmm.png',
      'description': 'Digital Frontiers Institute & The Fletcher School',
      'certificationLink':
          'https://app.diplomasafe.com/en-US/diploma/dcd9f2704d7a7993744dd7d26ac3c0bc88018e52c',
    },
    {
      'title': 'Software Architecture Foundation',
      'img': 'assets/certs/linkedin_sa.png',
      'description': 'LinkedIn Learning',
      'certificationLink': 'https://www.linkedin.com/in/mhk26/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 900;
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
                      'Certifications',
                      style: GoogleFonts.inter(
                        color:
                            isDarkMode ? AppColors.darkWhite : AppColors.black,
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
                      '  These are selected group of my certifications,\n  you can find my the rest in my LinkedIn account.',
                      style: GoogleFonts.inter(
                        color:
                            isDarkMode ? AppColors.darkWhite : AppColors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              isMobile ? buildMobileContent() : buildWebContent()
            ],
          ),
        );
      },
    );
  }

  Widget buildMobileContent() {
    return Column(
      children: certifications.map((cert) {
        return CertificationCard(
          title: cert['title']!,
          img: cert['img']!,
          description: cert['description']!,
          isDarkMode: isDarkMode,
          certificationLink: cert['certificationLink'],
        );
      }).toList(),
    );
  }

  Widget buildWebContent() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: certifications.map((cert) {
        return Container(
          width: 400, // Adjust width as needed
          child: CertificationCard(
            title: cert['title']!,
            img: cert['img']!,
            description: cert['description']!,
            isDarkMode: isDarkMode,
            certificationLink: cert['certificationLink'],
          ),
        );
      }).toList(),
    );
  }
}
