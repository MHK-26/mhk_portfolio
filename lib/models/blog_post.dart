class BlogPost {
  final String title;
  final String description;
  final String link;
  final DateTime publishDate;
  final String author;
  final List<String> categories;
  final String thumbnail;
  final int readingTime;

  BlogPost({
    required this.title,
    required this.description,
    required this.link,
    required this.publishDate,
    required this.author,
    required this.categories,
    this.thumbnail = '',
    this.readingTime = 5,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      publishDate: DateTime.tryParse(json['pubDate'] ?? '') ?? DateTime.now(),
      author: json['author'] ?? 'Mohammad Hisham',
      categories: json['categories'] != null 
          ? List<String>.from(json['categories']) 
          : [],
      thumbnail: json['thumbnail'] ?? '',
      readingTime: _calculateReadingTime(json['description'] ?? ''),
    );
  }

  static int _calculateReadingTime(String content) {
    // Simple reading time calculation (200 words per minute)
    final wordCount = content.split(' ').length;
    final readingTime = (wordCount / 200).ceil();
    return readingTime < 1 ? 1 : readingTime;
  }

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[publishDate.month - 1]} ${publishDate.day}, ${publishDate.year}';
  }

  String get readingTimeText {
    return '$readingTime min read';
  }
}