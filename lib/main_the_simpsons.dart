import 'package:character_viewer_exercise/flavor_config.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart';
import 'package:flutter/material.dart';

void main() {
  runAppWithFlavor(
    FlavorConfig()
      ..appTitle = "The Simpsons Character Viewer"
      ..apiEndpoint =
          "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
      ..imageLocation = "assets/images/the_simpson_no_image.jpeg"
      ..theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
  );
}
