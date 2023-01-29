import 'package:pokedex/pokedex.dart';

class PokemonDO {
  final PokemonSpecies? pokemonSpecies;
  final Pokemon pokemon;

  PokemonDO(this.pokemonSpecies, this.pokemon);
}

Future<PokemonDO> getPokemonInfo(int id) async {
  final pokedex = Pokedex();
  PokemonSpecies? pokemonSpecies;
  try {
    pokemonSpecies = await pokedex.pokemonSpecies.get(id: id);
  // ignore: empty_catches
  } catch (e) {
    pokemonSpecies = null;
  }
  Pokemon pokemon = await pokedex.pokemon.get(id:id);

  return PokemonDO(pokemonSpecies, pokemon);
}

Future<Ability> getAbilityInfo(String url) async {
  final pokedex = Pokedex();
  Ability pokemonAbility = await pokedex.abilities.getByUrl(url);
  return pokemonAbility;
}

getPokemonSprite(int id) {}