import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificationCard extends StatefulWidget {
  final String title;
  final String img;
  final String issuer;
  final String category;
  final String year;
  final List<String> skills;
  final bool isDarkMode;
  final String? certificationLink;

  const CertificationCard({
    super.key,
    required this.title,
    required this.img,
    required this.issuer,
    required this.category,
    required this.year,
    required this.skills,
    required this.isDarkMode,
    this.certificationLink,
  });

  @override
  State<CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<CertificationCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _shadowAnimation = Tween<double>(
      begin: 8.0,
      end: 16.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildModernCard(context);
  }

  Widget _buildModernCard(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                _isHovered = true;
              });
              _animationController.forward();
            },
            onExit: (_) {
              setState(() {
                _isHovered = false;
              });
              _animationController.reverse();
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isDarkMode
                      ? [Colors.grey[850]!, Colors.grey[800]!]
                      : [Colors.white, Colors.grey[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isHovered 
                      ? AppColors.gold.withOpacity(0.5)
                      : AppColors.gold.withOpacity(0.1),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                        ? AppColors.gold.withOpacity(0.2)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: _shadowAnimation.value,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image Section
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gold.withOpacity(0.1),
                          AppColors.gold.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            widget.img,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Content Section
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Category Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.gold.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              widget.category,
                              style: GoogleFonts.inter(
                                color: AppColors.gold,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Title
                          Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                              color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Issuer and Year
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.issuer,
                                  style: GoogleFonts.inter(
                                    color: widget.isDarkMode 
                                        ? AppColors.darkWhite.withOpacity(0.8)
                                        : AppColors.black.withOpacity(0.7),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: widget.isDarkMode 
                                      ? Colors.grey[700]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.year,
                                  style: GoogleFonts.inter(
                                    color: widget.isDarkMode 
                                        ? AppColors.darkWhite
                                        : AppColors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Skills
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: widget.skills.take(3).map((skill) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  skill,
                                  style: GoogleFonts.inter(
                                    color: AppColors.gold,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // View Button
                          if (widget.certificationLink != null)
                            SizedBox(
                              width: double.infinity,
                              height: 36,
                              child: ElevatedButton.icon(
                                onPressed: () => _launchURL(context, widget.certificationLink!),
                                icon: const Icon(Icons.open_in_new, size: 16),
                                label: Text(
                                  'View Certificate',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.gold,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }
}
