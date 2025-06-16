import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
              height: 450, // Fixed height for consistency
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isDarkMode
                      ? [Colors.black54, Colors.black87]
                      : [Colors.white, Colors.grey[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: _isHovered 
                    ? Border.all(color: AppColors.gold.withOpacity(0.3), width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                        ? AppColors.gold.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: _shadowAnimation.value,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.identity()
                          ..translate(0.0, _isHovered ? -5.0 : 0.0),
                        child: Image.asset(
                          widget.img,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: AppColors.gold.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.gold.withOpacity(0.5),
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.inter(
                      color: _isHovered 
                          ? AppColors.gold 
                          : AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(widget.title),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.description,
                                style: GoogleFonts.inter(
                                  color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                                  fontSize: constraints.maxWidth < 600 ? 14 : 16,
                                  height: 1.5,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildLinks(context),
                          ],
                        );
                      },
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

  Widget _buildLinks(BuildContext context) {
    List<Widget> links = [];

    if (widget.appStoreLink != null) {
      links.add(_buildLinkButton(
          context, 'App Store', 'assets/icons/apple.png', widget.appStoreLink!));
    }
    if (widget.playStoreLink != null) {
      links.add(_buildLinkButton(
          context, 'Play Store', 'assets/icons/play.png', widget.playStoreLink!));
    }
    if (widget.gitHubLink != null) {
      links.add(_buildLinkButton(
          context, 'GitHub', 'assets/icons/github.png', widget.gitHubLink!));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: links.map((link) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: link,
              );
            }).toList(),
          );
        }
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: links,
        );
      },
    );
  }

  Widget _buildLinkButton(
      BuildContext context, String label, String iconPath, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton.icon(
          onPressed: () {
            _launchURL(context, url);
          },
          icon: Image.asset(iconPath, width: 20, height: 20),
          label: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 4,
            shadowColor: AppColors.gold.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
          ),
        ),
      ),
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
