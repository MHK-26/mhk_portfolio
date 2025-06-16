import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/models/blog_post.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;
  final bool isDarkMode;

  const BlogCard({
    Key? key,
    required this.post,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard>
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
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _shadowAnimation = Tween<double>(
      begin: 8.0,
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
            child: GestureDetector(
              onTap: () => _launchURL(widget.post.link),
              child: Container(
                height: 420,
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
                    children: [
                      // Header with category and reading time
                      _buildHeader(),
                      
                      // Content section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: GoogleFonts.poppins(
                                  color: _isHovered 
                                      ? AppColors.gold
                                      : (widget.isDarkMode ? AppColors.darkWhite : AppColors.black),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                                child: Text(
                                  widget.post.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              
                              const SizedBox(height: 8),
                              
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
                              
                              // Description
                              Expanded(
                                child: Text(
                                  widget.post.description,
                                  style: GoogleFonts.inter(
                                    color: widget.isDarkMode 
                                        ? AppColors.darkWhite.withOpacity(0.85)
                                        : AppColors.black.withOpacity(0.75),
                                    fontSize: 15,
                                    height: 1.6,
                                    letterSpacing: 0.2,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Footer with author and date
                              _buildFooter(),
                              
                              const SizedBox(height: 16),
                              
                              // Read more button
                              _buildReadMoreButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gold.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold,
                    AppColors.gold.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.post.categories.isNotEmpty 
                    ? widget.post.categories.first 
                    : 'Blog',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Spacer(),
            // Reading time
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: widget.isDarkMode 
                    ? Colors.grey[700]?.withOpacity(0.8)
                    : Colors.grey[200]?.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: widget.isDarkMode 
                        ? AppColors.darkWhite.withOpacity(0.7)
                        : AppColors.black.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.post.readingTimeText,
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode 
                          ? AppColors.darkWhite.withOpacity(0.7)
                          : AppColors.black.withOpacity(0.6),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.gold.withOpacity(0.2),
                AppColors.gold.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.person_outline,
            size: 16,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.author,
                style: GoogleFonts.inter(
                  color: widget.isDarkMode 
                      ? AppColors.darkWhite.withOpacity(0.9)
                      : AppColors.black.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.post.formattedDate,
                style: GoogleFonts.inter(
                  color: widget.isDarkMode 
                      ? AppColors.darkWhite.withOpacity(0.6)
                      : AppColors.black.withOpacity(0.5),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadMoreButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () => _launchURL(widget.post.link),
        icon: AnimatedRotation(
          turns: _isHovered ? 0.1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Icon(Icons.article_outlined, size: 20),
        ),
        label: Text(
          'Read on Medium',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: Colors.white,
          elevation: _isHovered ? 12 : 6,
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