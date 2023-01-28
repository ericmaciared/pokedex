import 'package:pokedex/pokedex.dart';

class PokemonDO {
  final PokemonSpecies pokemonSpecies;
  final Pokemon pokemon;

  PokemonDO(this.pokemonSpecies, this.pokemon);
}

Future<PokemonDO> getPokemonInfo(int id) async {
  final pokedex = Pokedex();
  PokemonSpecies pokemonSpecies = await pokedex.pokemonSpecies.get(id: id);
  Pokemon pokemon = await pokedex.pokemon.get(id:id);
  print(pokemon);

  return PokemonDO(pokemonSpecies, pokemon);
}

getPokemonSprite(int id) {}

Future<void> main() async {
  final pokedex = Pokedex();

  Pokemon pokemon = await pokedex.pokemon.getByUrl('https://pokeapi.co/api/v2/pokemon/${15}/');
  PokemonSpecies pokemonSpecies = await pokedex.pokemonSpecies.get(id: 15);
  print(pokemon);

}
