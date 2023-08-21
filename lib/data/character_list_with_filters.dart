import 'package:character_viewer_exercise/data/character_service.dart';
import 'package:character_viewer_exercise/models/character.dart';
import 'package:character_viewer_exercise/screens/characters_homepage.dart'
    show searchTextEditingControllerProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_list_with_filters.g.dart';

@riverpod
class FilteredCharacters extends _$FilteredCharacters {
  List<Character> filterCharacters() {
    final filter = ref.read(searchTextEditingControllerProvider);
    final asyncCharacters = ref.watch(asyncCharactersProvider);

    List<Character> filteredList = [];

    if (filter.text == '' && asyncCharacters.value != null) {
      filteredList = asyncCharacters.value!;
      state = filteredList;
    } else if (asyncCharacters.value != null) {
      filteredList = asyncCharacters.value!
          .where(
            (element) => element.text.toLowerCase().contains(
                  filter.text.toLowerCase(),
                ),
          )
          .toList();
      state = filteredList;
    }

    return filteredList;
  }

  @override
  List<Character> build() {
    return filterCharacters();
  }
}
