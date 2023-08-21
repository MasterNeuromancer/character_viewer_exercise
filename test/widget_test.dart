// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:character_viewer_exercise/character_viewer_app.dart';
import 'package:character_viewer_exercise/flavor_config.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart'
    show flavorConfigProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Tests Character Viewer App', (WidgetTester tester) async {
    FlavorConfig config = FlavorConfig()
      ..appTitle = "The Simpsons Character Viewer"
      ..apiEndpoint =
          "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
      ..imageLocation = "assets/images/the_simpson_no_image.jpeg"
      ..theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      );
    flavorConfigProvider = StateProvider((ref) => config);
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: CharacterViewerApp(),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });
}
