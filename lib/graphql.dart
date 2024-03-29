import 'package:graphql/client.dart';

/// Adapter class for GraphQL queries

GraphQLClient getGraphQLClient() {
  final HttpLink httpLink = HttpLink("https://beta.pokeapi.co/graphql/v1beta");

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}

/// Gets all pokemon sprites for home page
Future<Map<String, dynamic>?> pokedexSprites() async {
  final GraphQLClient client = getGraphQLClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      r'''
        query MyQuery {
          pokemon_v2_pokemonsprites(limit: 150, where: {id: {_gte: 1, _lte: 150}}) {
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

Future<Map<String, dynamic>?> pokedexSpritesInRange(
    int lowerBound, int higherBound) async {

  final GraphQLClient client = getGraphQLClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query MyQuery {
          pokemon_v2_pokemonsprites(where: {id: {_gte: $lowerBound, _lte: $higherBound}}) {
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

/// Gets 15 pokemon sprites with starting characters like...
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

/// Gets 15 pokemon sprites with starting characters like...
Future<Map<String, dynamic>?> evolutionChainSprites(
    String evolutionChainId) async {
  final GraphQLClient client = getGraphQLClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query MyQuery {
          pokemon_v2_evolutionchain_aggregate(where: {id: {_eq: $evolutionChainId}}) {
            nodes {
              pokemon_v2_pokemonspecies {
                id
                name
                pokemon_v2_pokemons {
                  pokemon_v2_pokemonsprites {
                    sprites
                  }
                }
              }
            }
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

  final QueryOptions options = QueryOptions(
    document: gql(
      '''
        query MyQuery {
          pokemon_v2_evolutionchain_aggregate(where: {id: {_eq: 2}}) {
            nodes {
              pokemon_v2_pokemonspecies {
                id
                name
                pokemon_v2_pokemons {
                  pokemon_v2_pokemonsprites {
                    sprites
                  }
                }
              }
            }
          }
        }
      ''',
    ),
  );

  // Obtaining the result from options
  final QueryResult result = await client.query(options);

  // Return the desired sprite from map.
  print(result.data);
  print("A");
}
