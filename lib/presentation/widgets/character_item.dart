import 'package:flutter/material.dart';
import 'package:flutter_breacking/constant/my_colors.dart';
import 'package:flutter_breacking/constant/strings.dart';
import 'package:flutter_breacking/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: const EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
          color: MyColor.myWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, charactersDetailesScreen,
              arguments: character),
          child: GridTile(
            child: Hero(
              tag: character.id,
              child: Container(
                  color: MyColor.myGrey,
                  child: character.image.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: "assets/images/white.jpg",
                          image: character.image,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/images/white")),
            ),
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColor.myWhite,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
