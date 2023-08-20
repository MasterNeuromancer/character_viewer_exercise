import 'package:character_viewer_exercise/character.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart'
    show flavorConfigProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterDetails extends ConsumerWidget {
  const CharacterDetails({
    super.key,
    required this.details,
    required this.characterName,
  });

  final Character? details;
  final String characterName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String flavorFallbackImage =
        ref.watch(flavorConfigProvider.notifier).state.imageLocation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          characterName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                Image.network(
                  'https://duckduckgo.com/${details?.icon.url}',
                  fit: BoxFit.fitWidth,
                  height: 275,
                  errorBuilder:
                      (BuildContext _, Object exception, StackTrace? trace) {
                    return Image.asset(flavorFallbackImage);
                  },
                  frameBuilder: (
                    BuildContext _,
                    Widget image,
                    int? loadingBuilder,
                    bool __,
                  ) {
                    if (loadingBuilder == null) {
                      return CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      );
                    }
                    return Column(
                      children: [
                        image,
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  details?.text ?? '',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
