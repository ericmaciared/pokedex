import 'package:flutter/cupertino.dart';

class PokemonImage extends StatelessWidget {
  late String url;
  double size = 30;
  String imagePath;
  final spritesUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master";

  PokemonImage({super.key, required this.imagePath, this.size = 30}) {
    url = appendUrl(imagePath);
  }

  String appendUrl(String sprite) {
    final String url = sprite.replaceFirst("/media", spritesUrl);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
        width: size,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      )
    );
  }
}