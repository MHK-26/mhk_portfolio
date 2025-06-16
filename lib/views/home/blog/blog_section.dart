import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/models/blog_post.dart';
import 'package:mhk_portfolio_flutter/services/blog_service.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/views/home/blog/blog_card.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogSection extends StatefulWidget {
  final bool isDarkMode;

  const BlogSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  List<BlogPost> _blogPosts = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  
  final List<String> _categories = [
    'All',
    'Flutter',
    'Technology',
    'Cloud',
    'Mobile Development',
    'Architecture',
    'Development',
  ];

  @override
  void initState() {
    super.initState();
    _loadBlogPosts();
  }

  Future<void> _loadBlogPosts() async {
    try {
      final posts = await BlogService.fetchMediumPosts();
      if (mounted) {
        setState(() {
          _blogPosts = posts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<BlogPost> get filteredPosts {
    List<BlogPost> filtered = _blogPosts;

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((post) {
        return post.categories.any((category) => 
            category.toLowerCase().contains(_selectedCategory.toLowerCase()));
      }).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((post) {
        final title = post.title.toLowerCase();
        final description = post.description.toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double horizontalPadding = constraints.maxWidth < 600 ? 16 : 20;
        double fontSize = constraints.maxWidth < 600 ? 28 : 36;
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.article,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Blog',
                                style: GoogleFonts.inter(
                                  color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(2, 2),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Insights and thoughts on technology, development, and innovation.',
                                style: GoogleFonts.inter(
                                  color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                                  fontSize: constraints.maxWidth < 600 ? 14 : 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Medium link button
                    InkWell(
                      onTap: () async {
                        const url = 'https://mhk26.medium.com/';
                        try {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        } catch (e) {
                          // Handle error
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.gold.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.launch,
                              size: 16,
                              color: AppColors.gold,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'View all posts on Medium',
                              style: GoogleFonts.inter(
                                color: AppColors.gold,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Search and filter section
              _buildSearchAndFilter(constraints),
              
              const SizedBox(height: 20),
              
              // Content section
              _isLoading 
                  ? _buildLoadingState()
                  : _buildBlogContent(constraints),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchAndFilter(BoxConstraints constraints) {
    return Column(
      children: [
        // Search Bar
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            style: TextStyle(
              color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Search blog posts...',
              hintStyle: TextStyle(
                color: widget.isDarkMode 
                    ? AppColors.darkWhite.withOpacity(0.6) 
                    : AppColors.black.withOpacity(0.6),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.gold,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.gold, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              filled: true,
              fillColor: widget.isDarkMode 
                  ? Colors.grey[800]?.withOpacity(0.3) 
                  : Colors.grey[50],
            ),
          ),
        ),
        
        // Category Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white 
                          : widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: constraints.maxWidth < 600 ? 12 : 14,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (bool value) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  selectedColor: AppColors.gold,
                  backgroundColor: widget.isDarkMode 
                      ? Colors.grey[800] 
                      : Colors.grey[200],
                  checkmarkColor: Colors.white,
                  side: BorderSide(
                    color: isSelected 
                        ? AppColors.gold 
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading latest blog posts...',
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
    );
  }

  Widget _buildBlogContent(BoxConstraints constraints) {
    final filtered = filteredPosts;
    
    if (filtered.isEmpty) {
      return Container(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.article_outlined,
                size: 48,
                color: widget.isDarkMode 
                    ? AppColors.darkWhite.withOpacity(0.5)
                    : AppColors.black.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No blog posts found',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: widget.isDarkMode 
                      ? AppColors.darkWhite.withOpacity(0.7)
                      : AppColors.black.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your search or filter criteria',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: widget.isDarkMode 
                      ? AppColors.darkWhite.withOpacity(0.5)
                      : AppColors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid
        if (constraints.maxWidth > 1400) {
          return _buildGridLayout(filtered, 3); // Large desktop: 3 columns
        } else if (constraints.maxWidth > 900) {
          return _buildGridLayout(filtered, 2); // Desktop/Tablet: 2 columns
        } else {
          return _buildSingleColumnLayout(filtered); // Mobile: 1 column
        }
      },
    );
  }

  Widget _buildGridLayout(List<BlogPost> posts, int crossAxisCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.8,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 120)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(-15 * (1 - value), 40 * (1 - value)),
                child: Transform.scale(
                  scale: 0.9 + (0.1 * value),
                  child: Opacity(
                    opacity: value,
                    child: BlogCard(
                      post: posts[index],
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSingleColumnLayout(List<BlogPost> posts) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: posts.asMap().entries.map((entry) {
          final index = entry.key;
          final post = entry.value;
          
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 150)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(-20 * (1 - value), 30 * (1 - value)),
                child: Transform.scale(
                  scale: 0.9 + (0.1 * value),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: BlogCard(
                        post: post,
                        isDarkMode: widget.isDarkMode,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}