import 'package:flutter_test/flutter_test.dart';
import 'package:chili_task_flutter/main.dart';

void main() {
  testWidgets('Giphy search page is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const GiphyApp());
    expect(find.text('Giphy search'), findsOneWidget);
    expect(find.text('Search Gifs...'), findsOneWidget);
  });
}