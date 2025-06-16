import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mhk_portfolio_flutter/models/blog_post.dart';

class BlogService {
  static const String mediumRSSUrl = 'https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@mhk26';
  static const String fallbackMediumUrl = 'https://mhk26.medium.com/';
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static Future<List<BlogPost>> fetchMediumPosts() async {
    int retryCount = 0;
    Exception? lastException;

    while (retryCount < maxRetries) {
      try {
        final response = await http.get(
          Uri.parse(mediumRSSUrl),
          headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'Mozilla/5.0 (compatible; Portfolio-App/1.0)',
            'Accept': 'application/json',
            'Cache-Control': 'no-cache',
          },
        ).timeout(const Duration(seconds: 15));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          
          if (data['status'] == 'ok' && data['items'] != null) {
            final List<dynamic> items = data['items'];
            
            if (items.isEmpty) {
              throw Exception('No blog posts found in RSS feed');
            }
            
            return items.map((item) {
              try {
                final description = _cleanHtml(item['description'] ?? '');
                return BlogPost(
                  title: _cleanHtml(item['title'] ?? 'Untitled Post'),
                  description: _truncateDescription(description),
                  link: item['link'] ?? fallbackMediumUrl,
                  publishDate: DateTime.tryParse(item['pubDate'] ?? '') ?? DateTime.now(),
                  author: item['author'] ?? 'Mohammad Hisham',
                  categories: item['categories'] != null 
                      ? List<String>.from(item['categories']) 
                      : ['Technology'],
                  thumbnail: _extractThumbnail(item['description'] ?? ''),
                  readingTime: _calculateReadingTime(description),
                );
              } catch (e) {
                print('Error parsing individual blog post: $e');
                return null;
              }
            }).where((post) => post != null).cast<BlogPost>().toList();
          } else {
            throw Exception('API returned error status: ${data['status'] ?? 'unknown'}');
          }
        } else if (response.statusCode == 429) {
          // Rate limited - wait longer before retry
          await Future.delayed(Duration(seconds: 5 * (retryCount + 1)));
          throw Exception('Rate limited by RSS2JSON API');
        } else {
          throw Exception('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
        }
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());
        retryCount++;
        
        print('Blog fetch attempt $retryCount failed: $e');
        
        if (retryCount < maxRetries) {
          print('Retrying in ${retryDelay.inSeconds * retryCount} seconds...');
          await Future.delayed(retryDelay * retryCount); // Exponential backoff
        }
      }
    }
    
    // All retries failed, return fallback posts
    print('All blog fetch attempts failed. Using fallback posts. Last error: $lastException');
    return _getFallbackPosts();
  }
  
  static String _truncateDescription(String description) {
    if (description.length <= 200) return description;
    return '${description.substring(0, 200)}...';
  }
  
  static int _calculateReadingTime(String content) {
    // Average reading speed: 200 words per minute
    final wordCount = content.split(' ').length;
    final readingTime = (wordCount / 200).ceil();
    return readingTime < 1 ? 1 : readingTime;
  }

  static String _cleanHtml(String html) {
    // Remove HTML tags and decode entities
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  static String _extractThumbnail(String description) {
    // Extract image URL from description if available
    final imgMatch = RegExp(r'<img[^>]*src="([^"]*)"').firstMatch(description);
    return imgMatch?.group(1) ?? '';
  }

  static List<BlogPost> _getFallbackPosts() {
    // Fallback blog posts in case API fails
    return [
      BlogPost(
        title: 'Building Scalable Flutter Applications',
        description: 'Explore best practices for architecting large-scale Flutter applications with clean code principles and robust state management...',
        link: fallbackMediumUrl,
        publishDate: DateTime.now().subtract(const Duration(days: 7)),
        author: 'Mohammad Hisham',
        categories: ['Flutter', 'Mobile Development'],
        readingTime: 8,
      ),
      BlogPost(
        title: 'Cloud Architecture Patterns for Modern Apps',
        description: 'Deep dive into cloud architecture patterns that enable scalable, resilient, and cost-effective application development...',
        link: fallbackMediumUrl,
        publishDate: DateTime.now().subtract(const Duration(days: 14)),
        author: 'Mohammad Hisham',
        categories: ['Cloud', 'Architecture'],
        readingTime: 12,
      ),
      BlogPost(
        title: 'The Future of Cross-Platform Development',
        description: 'Analyzing the current state and future prospects of cross-platform development frameworks and their impact on software engineering...',
        link: fallbackMediumUrl,
        publishDate: DateTime.now().subtract(const Duration(days: 21)),
        author: 'Mohammad Hisham',
        categories: ['Technology', 'Development'],
        readingTime: 6,
      ),
    ];
  }
}