import 'package:flutter/material.dart';
import 'package:flutter_breacking/constant/my_colors.dart';
import 'package:flutter_breacking/data/models/characters.dart';

class CharactersDetailes extends StatelessWidget {
  final Character character;

  const CharactersDetailes({super.key, required this.character});
  Widget _buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 600,
        pinned: true,
        stretch: true,
        backgroundColor: MyColor.myGrey,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              character.name,
              style: const TextStyle(
                color: MyColor.myWhite,
              ),
            ),
            background: Hero(
              tag: character.id,
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
              ),
            )));
  }

  Widget _buildCharacterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: MyColor.myWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColor.myWhite,
                fontSize: 16,
              ))
        ]));
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      color: MyColor.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCharacterInfo('Statuse : ',character.status),
                    _buildDivider(300),
                    _buildCharacterInfo('Gender : ',character.gender),
                    _buildDivider(290),
                    _buildCharacterInfo('Actor/Actress : ',character.name),
                    _buildDivider(235),
                   const SizedBox(height: 20,)
                  ]),
            ),
             const SizedBox(height: 500,)
          ]))
        ],
      ),
    );
  }
}
