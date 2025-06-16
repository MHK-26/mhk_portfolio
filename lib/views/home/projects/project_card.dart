import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mhk_portfolio_flutter/widgets/image_popup.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String img;
  final String description;
  final bool isDarkMode;
  final String? appStoreLink;
  final String? playStoreLink;
  final String? gitHubLink;

  const ProjectCard({
    super.key,
    required this.title,
    required this.img,
    required this.description,
    required this.isDarkMode,
    this.appStoreLink,
    this.playStoreLink,
    this.gitHubLink,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> 
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
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _shadowAnimation = Tween<double>(
      begin: 7.0,
      end: 20.0,
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
    return _buildNarrowCard(context);
  }

  Widget _buildNarrowCard(BuildContext context) {
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
              height: 480, // Increased height for better content
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
                      ? AppColors.gold.withOpacity(0.6)
                      : AppColors.gold.withOpacity(0.1),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                        ? AppColors.gold.withOpacity(0.25)
                        : (widget.isDarkMode ? Colors.black45 : Colors.grey.withOpacity(0.15)),
                    spreadRadius: _isHovered ? 4 : 0,
                    blurRadius: _shadowAnimation.value,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.1),
                      spreadRadius: 8,
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section with Gradient Overlay
                    GestureDetector(
                      onTap: () => ImagePopup.show(
                        context,
                        widget.img,
                        widget.title,
                        widget.isDarkMode,
                      ),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.gold.withOpacity(0.1),
                              AppColors.gold.withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22),
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                transform: Matrix4.identity()
                                  ..scale(_isHovered ? 1.05 : 1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        widget.img,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: double.infinity,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              gradient: RadialGradient(
                                                colors: [
                                                  AppColors.gold.withOpacity(0.2),
                                                  AppColors.gold.withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.folder_special,
                                                    color: AppColors.gold,
                                                    size: 48,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Project Image',
                                                    style: GoogleFonts.inter(
                                                      color: AppColors.gold,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Gradient overlay for better text readability
                            if (_isHovered)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    topRight: Radius.circular(22),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      AppColors.gold.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Content Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with animated styling
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: GoogleFonts.poppins(
                                color: _isHovered 
                                    ? AppColors.gold 
                                    : (widget.isDarkMode ? AppColors.darkWhite : AppColors.black),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              child: Text(
                                widget.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Animated separator
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: _isHovered ? 60 : 40,
                              height: 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.gold,
                                    AppColors.gold.withOpacity(0.5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Description with better typography
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  widget.description,
                                  style: GoogleFonts.inter(
                                    color: widget.isDarkMode 
                                        ? AppColors.darkWhite.withOpacity(0.85)
                                        : AppColors.black.withOpacity(0.75),
                                    fontSize: 15,
                                    height: 1.6,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Action buttons
                            _buildEnhancedLinks(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedLinks(BuildContext context) {
    List<Map<String, dynamic>> links = [];

    if (widget.appStoreLink != null) {
      links.add({
        'label': 'App Store',
        'icon': Icons.apple,
        'url': widget.appStoreLink!,
        'color': Colors.blue[600]!,
      });
    }
    if (widget.playStoreLink != null) {
      links.add({
        'label': 'Play Store',
        'icon': Icons.play_arrow,
        'url': widget.playStoreLink!,
        'color': Colors.green[600]!,
      });
    }
    if (widget.gitHubLink != null) {
      links.add({
        'label': 'GitHub',
        'icon': Icons.code,
        'url': widget.gitHubLink!,
        'color': widget.isDarkMode ? Colors.white : Colors.grey[800]!,
      });
    }

    if (links.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.gold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.visibility_off,
              size: 16,
              color: AppColors.gold,
            ),
            const SizedBox(width: 8),
            Text(
              'Private Repository',
              style: GoogleFonts.inter(
                color: AppColors.gold,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (links.length == 1)
          _buildSingleEnhancedButton(links.first)
        else
          _buildMultipleEnhancedButtons(links),
      ],
    );
  }

  Widget _buildSingleEnhancedButton(Map<String, dynamic> linkData) {
    return Container(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () => _launchURL(context, linkData['url']),
        icon: Icon(
          linkData['icon'],
          size: 20,
          color: Colors.white,
        ),
        label: Text(
          linkData['label'],
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: Colors.white,
          elevation: _isHovered ? 8 : 4,
          shadowColor: AppColors.gold.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
        ),
      ),
    );
  }

  Widget _buildMultipleEnhancedButtons(List<Map<String, dynamic>> links) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: links.map((linkData) {
        return Container(
          height: 44,
          child: ElevatedButton.icon(
            onPressed: () => _launchURL(context, linkData['url']),
            icon: Icon(
              linkData['icon'],
              size: 18,
              color: Colors.white,
            ),
            label: Text(
              linkData['label'],
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: linkData['color'],
              foregroundColor: Colors.white,
              elevation: 3,
              shadowColor: linkData['color'].withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ).copyWith(
              overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
            ),
          ),
        );
      }).toList(),
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
