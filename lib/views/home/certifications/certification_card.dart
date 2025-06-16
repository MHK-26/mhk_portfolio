import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mhk_portfolio_flutter/widgets/image_popup.dart';

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
              height: 420, // Optimized height for content
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isDarkMode
                      ? [
                          Colors.grey[900]!,
                          Colors.grey[850]!,
                          Colors.grey[900]!,
                        ]
                      : [
                          Colors.white,
                          Colors.grey[50]!,
                          Colors.white,
                        ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered 
                      ? AppColors.gold.withOpacity(0.7)
                      : AppColors.gold.withOpacity(0.15),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                        ? AppColors.gold.withOpacity(0.3)
                        : (widget.isDarkMode ? Colors.black45 : Colors.grey.withOpacity(0.15)),
                    spreadRadius: _isHovered ? 6 : 0,
                    blurRadius: _shadowAnimation.value,
                    offset: Offset(0, _isHovered ? 10 : 4),
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.15),
                      spreadRadius: 12,
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Column(
                  children: [
                    // Full Width Certificate Image Header
                    Container(
                      height: 120,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => ImagePopup.show(
                          context,
                          widget.img,
                          widget.title,
                          widget.isDarkMode,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                          child: Stack(
                            children: [
                              // Full width image background
                              Positioned.fill(
                                child: Image.asset(
                                  widget.img,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.gold.withOpacity(0.3),
                                            AppColors.gold.withOpacity(0.1),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.workspace_premium,
                                          color: AppColors.gold,
                                          size: 48,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Gradient overlay for better text readability
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.3),
                                        Colors.black.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Zoom icon on hover
                              if (_isHovered)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.zoom_in,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              // Certificate info overlay
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Row(
                                  children: [
                                    // Category badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.gold,
                                            AppColors.gold.withOpacity(0.8),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        widget.category,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    // Year text
                                    Text(
                                      widget.year,
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                    // Enhanced Content Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with better typography
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: GoogleFonts.poppins(
                                color: _isHovered 
                                    ? AppColors.gold
                                    : (widget.isDarkMode ? AppColors.darkWhite : AppColors.black),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              child: Text(
                                widget.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Animated separator
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: _isHovered ? 50 : 30,
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.gold,
                                    AppColors.gold.withOpacity(0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Issuer with icon
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.school,
                                    size: 16,
                                    color: AppColors.gold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.issuer,
                                    style: GoogleFonts.inter(
                                      color: widget.isDarkMode 
                                          ? AppColors.darkWhite.withOpacity(0.85)
                                          : AppColors.black.withOpacity(0.75),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Simplified Skills and Action section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Skills section
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 40),
                                    child: Wrap(
                                      spacing: 6,
                                      runSpacing: 4,
                                      children: widget.skills.take(3).map((skill) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: AppColors.gold.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: AppColors.gold.withOpacity(0.2),
                                            ),
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
                                  ),
                                  const Spacer(),
                                  
                                  // Simplified action button
                                  if (widget.certificationLink != null)
                                    SizedBox(
                                      width: double.infinity,
                                      height: 36,
                                      child: ElevatedButton(
                                        onPressed: () => _launchURL(context, widget.certificationLink!),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.gold,
                                          foregroundColor: Colors.white,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          'View Certificate',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      width: double.infinity,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: widget.isDarkMode 
                                            ? Colors.grey[800]?.withOpacity(0.5)
                                            : Colors.grey[200]?.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Private Certificate',
                                          style: GoogleFonts.inter(
                                            color: widget.isDarkMode 
                                                ? AppColors.darkWhite.withOpacity(0.6)
                                                : AppColors.black.withOpacity(0.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
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
        ) // Closing Transform.scale
        ); // Closing parenthesis
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
