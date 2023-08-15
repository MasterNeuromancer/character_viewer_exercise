import 'package:character_viewer_exercise/character.dart';
import 'package:character_viewer_exercise/character_service.dart';
import 'package:character_viewer_exercise/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ViewCharactersHomePage extends ConsumerWidget {
  const ViewCharactersHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCharacters = ref.watch(asyncCharactersProvider);
    return asyncCharacters.when(
      data: (characters) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            for (final character in characters) ...[
              CharacterListTile(character: character),
            ]
          ],
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

class CharacterListTile extends StatefulWidget {
  const CharacterListTile({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  State<CharacterListTile> createState() => _CharacterListTileState();
}

class _CharacterListTileState extends State<CharacterListTile> {
  late String result2 =
      widget.character.text.substring(0, widget.character.text.indexOf('-'));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        result2,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      onTap: () => context.pushNamed(
        AppPages.characterDetails,
        extra: {
          'details': widget.character,
        },
      ),
    );
  }
}
