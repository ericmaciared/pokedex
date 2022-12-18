import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'styles.dart';
import 'Pokemon/pokemon_sprites.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    pokedexSprites();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

GraphQLClient getGraphQLClient() {
  final HttpLink httpLink = HttpLink("https://beta.pokeapi.co/graphql/v1beta");

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}

/// query example
Future<String> pokedexSprites() async {
  final GraphQLClient client = getGraphQLClient();

  final QueryOptions options = QueryOptions(
    document: gql(
      r'''
        query MyQuery {
          pokemon_v2_pokemonsprites(where: {id: {_eq: 25}}) {
            id
            sprites
          }
        }
      ''',
    ),
  );

  // Obtaining the result from options
  final QueryResult result = await client.query(options);
  // Getting sprites from object result.data, and convert the sprites string to a Map
  final Map<String, dynamic> spritesJson =
      jsonDecode(result.data!["pokemon_v2_pokemonsprites"][0]["sprites"]);

  // Return the desired sprite from map.
  return spritesJson["front_default"];
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String imgUrl = "";

    // TODO: Add Image.network with retreived imgUrl to images

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        // TODO: change this for proper buttons
        leading: BackButton(),
        actions: [BackButton()],
      ),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.mainPadding),
        Styles.H1("PokéDex"),
        SizedBox(height: Styles.mainPadding),
        FutureBuilder<String>(
          future: pokedexSprites(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 150,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 30,
                        child: Image.network(snapshot.data!, errorBuilder:
                            (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
                          return const Text('ð¢');
                        }));
                  });
            } else {
              return const CircularProgressIndicator(strokeWidth: 4);
            }
          },
        )
      ])),
    );
  }
}
