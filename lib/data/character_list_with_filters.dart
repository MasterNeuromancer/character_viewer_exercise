import 'package:character_viewer_exercise/data/character_service.dart';
import 'package:character_viewer_exercise/models/character.dart';
import 'package:character_viewer_exercise/screens/characters_homepage.dart'
    show searchTextProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_list_with_filters.g.dart';

@riverpod
List<Character> characterListWithFilters(CharacterListWithFiltersRef ref) {
  final filter = ref.watch(searchTextProvider);
  final asyncCharacters = ref.watch(asyncCharactersProvider);

  List<Character> filteredList = [];

  if (filter == '' && asyncCharacters.value != null) {
    filteredList = asyncCharacters.value!;
  } else if (asyncCharacters.value != null) {
    filteredList = asyncCharacters.value!
        .where(
          (element) => element.text.toLowerCase().contains(
                filter.toLowerCase(),
              ),
        )
        .toList();
  }

  return filteredList;
}
