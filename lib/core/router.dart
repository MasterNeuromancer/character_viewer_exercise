import 'package:character_viewer_exercise/screens/character_details.dart';
import 'package:character_viewer_exercise/screens/characters_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppPages {
  static String viewCharactersHomePage = '/';
  static String characterDetails = '/character_details';
}

final Provider<GoRouter> routerProvider =
    Provider<GoRouter>((ProviderRef<GoRouter> ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppPages.viewCharactersHomePage,
    routes: <GoRoute>[
      GoRoute(
        path: AppPages.viewCharactersHomePage,
        builder: (BuildContext context, GoRouterState state) {
          return const CharactersHomePage();
        },
        routes: <GoRoute>[
          GoRoute(
            path: 'character_details',
            name: AppPages.characterDetails,
            builder: (BuildContext context, GoRouterState state) {
              final params = state.extra as Map?;
              return CharacterDetails(
                details: params?['details'],
                characterName: params?['characterName'],
              );
            },
          ),
        ],
      ),
    ],
  );
});
