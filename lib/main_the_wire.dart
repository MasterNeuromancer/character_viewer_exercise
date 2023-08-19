import 'package:character_viewer_exercise/flavor_config.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart';
import 'package:flutter/material.dart';

void main() {
  runAppWithFlavor(
    FlavorConfig()
      ..appTitle = "The Wire Character Viewer"
      ..apiEndpoint =
          "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
      ..theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
        useMaterial3: true,
      ),
  );
}
