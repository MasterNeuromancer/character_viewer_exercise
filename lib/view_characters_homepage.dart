import 'package:character_viewer_exercise/character.dart';
import 'package:character_viewer_exercise/character_details.dart';
import 'package:character_viewer_exercise/character_service.dart';
import 'package:character_viewer_exercise/router.dart';
import 'package:character_viewer_exercise/run_app_with_flavor.dart'
    show flavorConfigProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ViewCharactersHomePage extends ConsumerStatefulWidget {
  const ViewCharactersHomePage({super.key});

  @override
  ConsumerState<ViewCharactersHomePage> createState() =>
      _ViewCharactersHomePageState();
}

class _ViewCharactersHomePageState
    extends ConsumerState<ViewCharactersHomePage> {
  Character? selectedCharacter;
  String selectedCharacterName = '';

  @override
  Widget build(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    double screenWidth = MediaQuery.of(context).size.width;
    final bool useMobileLayout = shortestSide < 550;
    final asyncCharacters = ref.watch(asyncCharactersProvider);
    String flavorTitle =
        ref.watch(flavorConfigProvider.notifier).state.appTitle;

    return asyncCharacters.when(
      data: (characters) {
        if (useMobileLayout) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(flavorTitle),
              centerTitle: true,
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  onChanged: (value) {
                    ref
                        .read(asyncCharactersProvider.notifier)
                        .filterCharacters(value.trim());
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search for character',
                    suffixIcon: IconButton(
                      onPressed: () {
                        ref
                            .read(asyncCharactersProvider.notifier)
                            .filterCharacters('');
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      String characterName;

                      if (characters[index].text.contains('-')) {
                        characterName = characters[index]
                            .text
                            .substring(0, characters[index].text.indexOf('-'))
                            .trim();
                      } else {
                        characterName = characters[index].text;
                      }
                      return CharacterListTile(
                        character: characters[index],
                        characterName: characterName,
                        onTap: () => context.pushNamed(
                          AppPages.characterDetails,
                          extra: {
                            'details': characters[index],
                            'characterName': characterName,
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Tablet Mode'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  ref
                      .read(asyncCharactersProvider.notifier)
                      .filterCharacters(value.trim());
                },
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: characters.length,
                        itemBuilder: (BuildContext context, int index) {
                          String characterName;
                          if (characters[index].text.contains('-')) {
                            characterName = characters[index]
                                .text
                                .substring(
                                    0, characters[index].text.indexOf('-'))
                                .trim();
                          } else {
                            characterName = characters[index].text;
                          }

                          return CharacterListTile(
                            character: characters[index],
                            characterName: characterName,
                            // onTap: () => context.pushNamed(
                            //   AppPages.characterDetails,
                            //   extra: {
                            //     'details': characters[index],
                            //     'characterName': characterName,
                            //   },
                            // ),
                            onTap: () {
                              setState(() {
                                selectedCharacter = characters[index];
                                selectedCharacterName = characterName;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 2,
                      child: CharacterDetails(
                        details: selectedCharacter,
                        characterName: selectedCharacterName,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Scaffold(
        body: Center(
          child: Text('Error: $err'),
        ),
      ),
    );
  }
}

class CharacterListTile extends StatelessWidget {
  const CharacterListTile({
    super.key,
    required this.character,
    required this.characterName,
    required this.onTap,
  });

  final Character character;
  final String characterName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        characterName,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      onTap: onTap,
    );
  }
}
