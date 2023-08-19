import 'package:character_viewer_exercise/character.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({
    super.key,
    required this.details,
    required this.characterName,
  });

  final Character? details;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(characterName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                Image.network(
                  'https://duckduckgo.com/${details?.icon.url}',
                  fit: BoxFit.fitWidth,
                  height: 250,
                  errorBuilder:
                      (BuildContext _, Object exception, StackTrace? trace) {
                    return const Icon(
                      Icons.person,
                      size: 105,
                    );
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
                  height: 35,
                ),
                Text(
                  details?.text ?? '',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
