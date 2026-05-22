class GifItem {
  final String id;
  final String title;
  final String previewUrl;
  final String originalUrl;
  final String username;

  const GifItem({
    required this.id,
    required this.title,
    required this.previewUrl,
    required this.originalUrl,
    required this.username,
  });

  factory GifItem.fromJson(Map<String, dynamic> json) {
    final images =json['images'] as Map<String, dynamic>? ?? {};
    final fixedWidth = images['fixed_width'] as Map<String, dynamic>? ?? {};
    final original =images['original'] as Map<String, dynamic>? ?? {};
    return GifItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled GIF',
      previewUrl: fixedWidth['url'] as String? ?? '',
      originalUrl: original['url'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  } 
}