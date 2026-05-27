import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/models/gif_item.dart';

class GifDetailPage extends StatelessWidget {
  final GifItem gif;
  const GifDetailPage({
    super.key,
    required this.gif, 
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gif.title.isEmpty ? 'Gif Details' : gif.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: gif.originalUrl,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(Icons.broken_image, size:48),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              gif.title.isEmpty ? 'Untitled Gif' : gif.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height:8),
            Text(
              'Giphy ID : ${gif.id}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }
}