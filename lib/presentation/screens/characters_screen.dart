import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breacking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breacking/constant/my_colors.dart';
import 'package:flutter_breacking/data/models/characters.dart';
import 'package:flutter_breacking/presentation/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Can\'t Connect....Check The Internt',
                style: TextStyle(fontSize: 22, color: MyColor.myGrey),
              ),
              Image.asset(
                "assets/images/offline.png",
                height: 200,
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFeild() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColor.myGrey,
      decoration: const InputDecoration(
        hintText: "Find a character...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColor.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColor.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacter) {
    searchForCharacters = allCharacters
        .where((Character) =>
            Character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppAction() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColor.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColor.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlokWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLodedStateWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 10,
        color: MyColor.myGrey,
      ),
    );
  }

  Widget buildLodedStateWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGrey,
        child: Column(children: [
          buildCharactersList(),
        ]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchForCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
              character: _searchTextController.text.isEmpty
                  ? allCharacters[index]
                  : searchForCharacters[index]);
        });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(
        color: MyColor.myGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myYellow,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.myYellow,
        title: _isSearching ? _buildSearchFeild() : _buildAppBarTitle(),
        actions: _buildAppAction(),
        leading: _isSearching
            ? const BackButton(
                color: MyColor.myGrey,
              )
            : Container(),
      ),
      body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return buildBlokWidget();
            } else {
              return buildNoInternetWidget();
            }
          },
          child: showLoadingIndicator()),
    );
  }
}
