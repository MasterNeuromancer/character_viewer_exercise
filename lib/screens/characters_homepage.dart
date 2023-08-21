import 'package:character_viewer_exercise/data/character_list_with_filters.dart';
import 'package:character_viewer_exercise/models/character.dart';
import 'package:character_viewer_exercise/screens/character_details.dart';
import 'package:character_viewer_exercise/core/router.dart';
import 'package:character_viewer_exercise/core/run_app_with_flavor.dart'
    show flavorConfigProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final searchTextEditingControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());

class CharactersHomePage extends ConsumerStatefulWidget {
  const CharactersHomePage({super.key});

  @override
  ConsumerState<CharactersHomePage> createState() => _CharactersHomePageState();
}

class _CharactersHomePageState extends ConsumerState<CharactersHomePage> {
  Character? selectedCharacter;
  String selectedCharacterName = 'Select a Character';

  @override
  Widget build(BuildContext context) {
    String flavorTitle =
        ref.watch(flavorConfigProvider.notifier).state.appTitle;
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    double screenWidth = MediaQuery.of(context).size.width;
    final bool useMobileLayout = shortestSide < 550;
    final TextEditingController searchController =
        ref.watch(searchTextEditingControllerProvider);
    final filteredCharacters = ref.watch(filteredCharactersProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          flavorTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: searchController,
              style: Theme.of(context).textTheme.headlineMedium,
              onChanged: (value) => ref
                  .watch(filteredCharactersProvider.notifier)
                  .filterCharacters(),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                hintText: 'Search for character',
                hintStyle: Theme.of(context).textTheme.headlineSmall,
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.text = '';
                    ref
                        .watch(filteredCharactersProvider.notifier)
                        .filterCharacters();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 3.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 3.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          if (useMobileLayout) ...[
            Expanded(
              child: ListView.builder(
                itemCount: filteredCharacters.length,
                itemBuilder: (BuildContext context, int index) {
                  String characterName;

                  if (filteredCharacters[index].text.contains('-')) {
                    characterName = filteredCharacters[index]
                        .text
                        .substring(
                            0, filteredCharacters[index].text.indexOf('-'))
                        .trim();
                  } else {
                    characterName = filteredCharacters[index].text;
                  }
                  return CharacterListTile(
                    character: filteredCharacters[index],
                    characterName: characterName,
                    onTap: () => context.pushNamed(
                      AppPages.characterDetails,
                      extra: {
                        'details': filteredCharacters[index],
                        'characterName': characterName,
                      },
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCharacters.length,
                      itemBuilder: (BuildContext context, int index) {
                        String characterName;
                        if (filteredCharacters[index].text.contains('-')) {
                          characterName = filteredCharacters[index]
                              .text
                              .substring(0,
                                  filteredCharacters[index].text.indexOf('-'))
                              .trim();
                        } else {
                          characterName = filteredCharacters[index].text;
                        }

                        return CharacterListTile(
                          character: filteredCharacters[index],
                          characterName: characterName,
                          onTap: () {
                            setState(() {
                              selectedCharacter = filteredCharacters[index];
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
          ]
        ],
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
        style: Theme.of(context).textTheme.displaySmall,
      ),
      onTap: onTap,
    );
  }
}
