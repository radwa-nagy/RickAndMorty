import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breacking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breacking/constant/strings.dart';
import 'package:flutter_breacking/data/models/characters.dart';
import 'package:flutter_breacking/data/repositry/characters_repository.dart';
import 'package:flutter_breacking/data/web_services/characters_web_services.dart';
import 'package:flutter_breacking/presentation/screens/character_screen_detailes.dart';
import 'package:flutter_breacking/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit characterCubit;
  AppRouter() {
    characterRepository = CharacterRepository(CharachterWebServices());
    characterCubit = CharactersCubit(characterRepository);
  }

  Route? generatRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreens:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: const CharactersScreen(),
                ));
      case charactersDetailesScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>  CharactersDetailes(character: character,));
    }
  }
}
