import 'package:flutter/material.dart';

class GifSearchPage extends StatelessWidget {
  const GifSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giphy Search'),
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for GIFs',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  'Search results will appear here',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),)
      ),
    );
  }
}