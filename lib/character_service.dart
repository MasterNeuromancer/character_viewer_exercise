import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:character_viewer_exercise/character.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_service.g.dart';

@riverpod
class AsyncCharacters extends _$AsyncCharacters {
  Future<List<Character>> _fetchTodo() async {
    Uri url = Uri.parse(
        'http://api.duckduckgo.com/?q=the+wire+characters&format=json');
    final res = await http.get(url);
    final charactersRes = jsonDecode(res.body);
    final listOfCharacters =
        CharacterResponse.fromJson(charactersRes).characters;

    return listOfCharacters;
  }

  @override
  FutureOr<List<Character>> build() async {
    // Load initial todo list from the remote repository
    return _fetchTodo();
  }
}
