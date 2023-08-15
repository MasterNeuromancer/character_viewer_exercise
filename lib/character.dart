class CharacterResponse {
  CharacterResponse({
    required this.characters,
  });
  late final List<Character> characters;

  CharacterResponse.fromJson(Map<String, dynamic> json) {
    characters = List.from(json['RelatedTopics'])
        .map((e) => Character.fromJson(e))
        .toList();
  }
}

class Character {
  Character({
    required this.firstURL,
    required this.icon,
    required this.result,
    required this.text,
  });
  late final String firstURL;
  late final CharacterIcon icon;
  late final String result;
  late final String text;

  Character.fromJson(Map<String, dynamic> json) {
    firstURL = json['FirstURL'];
    icon = CharacterIcon.fromJson(json['Icon']);
    result = json['Result'];
    text = json['Text'];
  }
}

class CharacterIcon {
  CharacterIcon({
    required this.height,
    required this.url,
    required this.width,
  });
  late final String height;
  late final String url;
  late final String width;

  CharacterIcon.fromJson(Map<String, dynamic> json) {
    height = json['Height'];
    url = json['URL'];
    width = json['Width'];
  }
}
