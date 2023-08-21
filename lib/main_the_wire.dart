import 'package:character_viewer_exercise/flavor_config.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runAppWithFlavor(
    FlavorConfig()
      ..appTitle = "The Wire Character Viewer"
      ..apiEndpoint =
          "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
      ..imageLocation = "assets/images/the_wire_person.png"
      ..theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
  );
}
