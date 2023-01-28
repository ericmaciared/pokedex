import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/pokemon/api_adapter.dart';
import 'styles.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key, required this.id});

  final int id;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late Future<PokemonDO> pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = getPokemonInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Styles.H3('Nº${widget.id}', Styles.mainGray),
          centerTitle: true,
          iconTheme: IconThemeData(color: Styles.mainGray),
          leading: const BackButton(),
          actions: const [
            IconButton(
              icon: Icon(Icons.catching_pokemon, color: Colors.red),
              //TODO: MArk pokemon as captured
              onPressed: null,
            )
          ]),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: Styles.mainPadding),
        buildImage(),
        FutureBuilder<PokemonDO>(
            future: pokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    buildInfo(snapshot.data!),
                    buildStats(snapshot.data!),
                    buildEvolutions(snapshot.data!),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator(strokeWidth: 4);
            }),
        SizedBox(height: Styles.mainPadding)
      ])),
    );
  }

  Widget buildImage() {
    String imgUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${widget.id}.png";
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
        child: Center(
          child: Container(
              height: 350,
              padding: EdgeInsets.all(Styles.mainPadding),
              /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
              child: Image.network(imgUrl)),
        ));
  }

  Widget buildInfo(PokemonDO pokemon) {
    return Container(
        padding: EdgeInsets.all(Styles.mainPadding),
        child: Column(children: [
          Styles.H1(pokemon.pokemonSpecies.name.toCapitalized(), Colors.black),
          Styles.H4(pokemon.pokemonSpecies.genera[7].genus, Colors.black),
          SizedBox(height: Styles.mainPadding),
          typeImage(pokemon.pokemon.types),
          SizedBox(height: Styles.mainPadding),
          Styles.H5(
              pokemon.pokemonSpecies.flavorTextEntries.first.flavorText
                  .toString()
                  .replaceAll("\n", " ").replaceAll("\f", " "),
              Styles.mainGray),
          SizedBox(height: Styles.mainPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.H4('Height', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Weight', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Abilities', Colors.black),
                ],
              ),
              SizedBox(width: Styles.sidePadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.H4(
                      '${pokemon.pokemon.height / 10} m', Styles.mainGray),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4(
                      '${pokemon.pokemon.weight / 10} kg', Styles.mainGray),
                  buildAbilities(pokemon.pokemon.abilities)
                ],
              )
            ],
          )
        ]));
  }

  Widget buildStats(PokemonDO pokemon) {
    return Container(
        padding: EdgeInsets.all(Styles.mainPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Styles.H3('Base Stats', Colors.black),
          SizedBox(height: Styles.sidePadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Styles.H4('HP', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Attack', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Defense', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Sp. Atk', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('SP. Def', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Speed', Colors.black),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Total', Colors.black),
                ],
              ),
              SizedBox(width: Styles.sidePadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  statBar(pokemon.pokemon.stats[0].baseStat),
                  SizedBox(height: Styles.sidePadding),
                  statBar(pokemon.pokemon.stats[1].baseStat),
                  SizedBox(height: Styles.sidePadding),
                  statBar(pokemon.pokemon.stats[2].baseStat),
                  SizedBox(height: Styles.sidePadding),
                  statBar(pokemon.pokemon.stats[3].baseStat),
                  SizedBox(height: Styles.sidePadding),
                  statBar(pokemon.pokemon.stats[4].baseStat),
                  SizedBox(height: Styles.sidePadding),
                  statBar(pokemon.pokemon.stats[5].baseStat),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4(
                      "${pokemon.pokemon.stats[0].baseStat + pokemon.pokemon.stats[1].baseStat + pokemon.pokemon.stats[2].baseStat + pokemon.pokemon.stats[3].baseStat + pokemon.pokemon.stats[4].baseStat + pokemon.pokemon.stats[5].baseStat}",
                      Colors.black),
                ],
              ),
              SizedBox(width: Styles.sidePadding),
            ],
          )
        ]));
  }

  Widget buildEvolutions(PokemonDO pokemon) {
    return Container(
        padding: EdgeInsets.all(Styles.mainPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Styles.H3('Evolutions & Forms', Colors.black),
          SizedBox(height: Styles.sidePadding),
          Container(
            alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
                color: Styles.secondaryGray,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: IconButton(iconSize: 100, onPressed: null, icon: Image.asset('assets/icon_150.png'),
            )
          )
        ]));
  }

  Widget typeImage(List<PokemonType> types) {
    if (types.length == 2) {
      return Wrap(
        spacing: Styles.sidePadding,
        alignment: WrapAlignment.center,
        children: [
          Image.asset('assets/types/${types.first.type.name}.png', width: 30),
          Image.asset('assets/types/${types.last.type.name}.png', width: 30),
        ],
      );
    }
    return Wrap(
      spacing: Styles.sidePadding,
      alignment: WrapAlignment.center,
      children: [
        Image.asset('assets/types/${types.first.type.name}.png', width: 30),
      ],
    );
  }

  Widget statBar(int value) {
    double barWidth = MediaQuery.of(context).size.width * 0.5 * value / 255;
    Color barColor = Colors.green;
    if (value < 40)
      barColor = Colors.red;
    else if (value < 80)
      barColor = Colors.amberAccent;
    else if (value < 110)
      barColor = Colors.green;
    else
      barColor = Colors.lightBlue;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Styles.H4(value.toString(), Colors.black),
        ),
        SizedBox(width: Styles.sidePadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: barColor,
              width: barWidth,
              height: Styles.sidePadding,
            )
          ],
        )
      ],
    );
  }


  // TODO: This can be optimized with a ListView builder, but I keep getting errors from size constraints
  Widget buildAbilities(List<PokemonAbility> abilities) {
    switch (abilities.length) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Styles.sidePadding),
            Styles.H4(abilities[0].ability.name.toClean(), Styles.mainGray)
          ]
        );
      case 2:
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Styles.sidePadding),
              Styles.H4(abilities[0].ability.name.toClean(), Styles.mainGray),
              SizedBox(height: Styles.sidePadding),
              Styles.H4(abilities[1].ability.name.toClean(), Styles.mainGray)
            ]
        );
      case 3:
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Styles.sidePadding),
              Styles.H4(abilities[0].ability.name.toClean(), Styles.mainGray),
              SizedBox(height: Styles.sidePadding),
              Styles.H4(abilities[1].ability.name.toClean(), Styles.mainGray),
              SizedBox(height: Styles.sidePadding),
              Styles.H4(abilities[2].ability.name.toClean(), Styles.mainGray)
            ]
        );
      default:
        return Container();
    }
  }

}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String toClean() =>
      replaceAll("\n", " ").replaceAll("\f", " ").replaceAll("-", " ").toTitleCase();
}
