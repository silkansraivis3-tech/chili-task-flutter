import 'package:flutter_test/flutter_test.dart';
import 'package:chili_task_flutter/features/gifs/data/models/gif_item.dart';

void main(){
  test("GifItem creates object from GIPHY json", () {
    final json = {
      'id': 'abc123',
      'title': 'Funny Cat GIF',
      'username': 'giphyuser',
      'images': {
        'fixed_width': {
          'url': 'https://example.com/preview.gif',
        },
        'original': {
          'url': 'https://example.com/original.gif',
        },
      },
    };
    final gif = GifItem.fromJson(json);
    expect(gif.id, 'abc123');
    expect(gif.title, 'Funny Cat GIF');
    expect(gif.username, 'giphyuser');
    expect(gif.previewUrl, 'https://example.com/preview.gif');
    expect(gif.originalUrl, 'https://example.com/original.gif');
  });
}