import 'package:character_viewer_exercise/flavor_config.dart';
import 'package:character_viewer_exercise/router.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart'
    show flavorConfigProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharacterViewerApp extends ConsumerWidget {
  const CharacterViewerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);
    final FlavorConfig flavorConfig = ref.read(flavorConfigProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: flavorConfig.appTitle,
      theme: flavorConfig.theme,
    );
  }
}
