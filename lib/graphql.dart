import 'package:graphql/client.dart';

/**
 * Adapter class for GraphQL queries
 */

GraphQLClient getGraphQLClient() {
  final HttpLink httpLink = HttpLink("https://beta.pokeapi.co/graphql/v1beta");

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}

/**
 * Gets all pokemon sprites for home page
 */
Future<Map<String, dynamic>?> pokedexSprites() async {
  final GraphQLClient client = getGraphQLClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      r'''
        query MyQuery {
          pokemon_v2_pokemonsprites(limit: 150) {
            id
            sprites
          }
        }
      ''',
    ),
  );

  // Obtaining the result from options
  final QueryResult result = await client.query(options);

  // Return the desired sprite from map.
  return result.data;
}

/**
 * Gets 15 pokemon sprites with starting characters like...
 */
Future<Map<String, dynamic>?> pokedexSpritesStartingWith(String search) async {
  final GraphQLClient client = getGraphQLClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query MyQuery {
          pokemon_v2_pokemonsprites(where: {pokemon_v2_pokemon: {name: {_ilike: "$search%"}}}, limit: 15) {
            pokemon_id
            pokemon_v2_pokemon {
              name
            }
            sprites
          }
        }


      ''',
    ),
  );

  // Obtaining the result from options
  final QueryResult result = await client.query(options);

  // Return the desired sprite from map.
  return (result.data);
}

Future<void> main() async {
  final GraphQLClient client = getGraphQLClient();
  final String search = "a";

  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query MyQuery {
          pokemon_v2_pokemonsprites(where: {pokemon_v2_pokemon: {name: {_ilike: "$search%"}}}, limit: 15) {
            pokemon_id
            pokemon_v2_pokemon {
              name
            }
            sprites
          }
        }


      ''',
    ),
  );

  // Obtaining the result from options
  final QueryResult result = await client.query(options);

  // Return the desired sprite from map.
  final List<dynamic> pokemons = result.data!["pokemon_v2_pokemonsprites"];
  final int length = pokemons.length;
  print(pokemons);
  print("A");
}
