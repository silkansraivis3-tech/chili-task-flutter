import 'package:flutter/material.dart';
import 'package:chili_task_flutter/features/gifs/presentation/pages/gif_search_page.dart';
void main() {
  runApp(const GiphyApp());
}
class GiphyApp extends StatelessWidget {
  const GiphyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giphy Search',
      theme:ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      ),
      home:const GifSearchPage(),
    );
  }
}