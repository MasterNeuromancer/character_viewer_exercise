import 'package:character_viewer_exercise/character_viewer_app.dart';
import 'package:character_viewer_exercise/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late StateProvider<FlavorConfig> flavorConfigProvider;

Future<void> runAppWithFlavor(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );

  flavorConfigProvider = StateProvider((ref) => config);

  runApp(
    const ProviderScope(
      child: CharacterViewerApp(),
    ),
  );
}
