import 'package:flutter_breacking/data/models/characters.dart';
import 'package:flutter_breacking/data/web_services/characters_web_services.dart';

class CharacterRepository {
  final CharachterWebServices characterWebService;

  CharacterRepository(this.characterWebService);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebService.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
