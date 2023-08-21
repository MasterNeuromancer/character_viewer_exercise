import 'dart:async';
import 'dart:convert';

import 'package:character_viewer_exercise/core/run_app_with_flavor.dart'
    show flavorConfigProvider;
import 'package:http/http.dart' as http;
import 'package:character_viewer_exercise/models/character.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_service.g.dart';

@riverpod
class AsyncCharacters extends _$AsyncCharacters {
  Future<List<Character>> _fetchCharacters() async {
    String flavorEndpoint =
        ref.read(flavorConfigProvider.notifier).state.apiEndpoint;
    Uri url = Uri.parse(flavorEndpoint);
    final res = await http.get(url);
    final charactersRes = jsonDecode(res.body);
    final listOfCharacters =
        CharacterResponse.fromJson(charactersRes).characters;

    return listOfCharacters;
  }

  @override
  FutureOr<List<Character>> build() async {
    return _fetchCharacters();
  }
}
