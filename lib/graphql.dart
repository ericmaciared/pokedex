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
