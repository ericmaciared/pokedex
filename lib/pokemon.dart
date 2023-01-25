import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokedex/login.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'styles.dart';
import 'graphql.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key, required this.id});

  final int id;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Styles.H3('Nº150', Styles.mainGray),
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
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Styles.sidePadding),
            child: Center(
              child: Container(
                  height: 350,
                  padding: EdgeInsets.all(Styles.mainPadding),
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('assets/150.png')),
            )),
        buildInfo(),
        buildStats(),
        buildEvolutions(),
        SizedBox(height: Styles.mainPadding)
      ])),
    );
  }

  Widget buildInfo() {
    return Container(
        padding: EdgeInsets.all(Styles.mainPadding),
        child: Column(children: [
          Styles.H1('Mewtwo', Colors.black),
          Styles.H4('Genetic Pokemon', Colors.black),
          SizedBox(height: Styles.mainPadding),
          typeImage(['psychic']),
          SizedBox(height: Styles.mainPadding),
          Styles.H5(
              'Mewtwo was created by recombining Mew’s genes. It’s said to have the most savage heart among Pokémon.',
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
                  Styles.H4('2.0 m (6′07″)', Styles.mainGray),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('122.0 kg (269.0 lbs)', Styles.mainGray),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Pressure', Styles.mainGray),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('Unnerve (hidden ability)', Styles.mainGray),
                ],
              )
            ],
          )
        ]));
  }

  Widget buildStats() {
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
                  statBar(106),
                  SizedBox(height: Styles.sidePadding),
                  statBar(110),
                  SizedBox(height: Styles.sidePadding),
                  statBar(90),
                  SizedBox(height: Styles.sidePadding),
                  statBar(154),
                  SizedBox(height: Styles.sidePadding),
                  statBar(90),
                  SizedBox(height: Styles.sidePadding),
                  statBar(130),
                  SizedBox(height: Styles.sidePadding),
                  Styles.H4('680', Colors.black),
                ],
              ),
              SizedBox(width: Styles.sidePadding),
            ],
          )
        ]));
  }

  Widget buildEvolutions() {
    return Container(
        padding: EdgeInsets.all(Styles.mainPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Styles.H3('Evolutions & Forms', Colors.black),
          SizedBox(height: Styles.sidePadding),
          Container(
            alignment: Alignment.center,
            height: 200,
            decoration: BoxDecoration(
                color: Styles.secondaryGray,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Image.asset('assets/icon_150.png'),
          )
        ]));
  }

  Widget typeImage(List<String> types) {
    if (types.length == 2) {
      return Wrap(
        spacing: Styles.sidePadding,
        alignment: WrapAlignment.center,
        children: [
          Image.asset('assets/types/${types[0]}.png', width: 30),
          Image.asset('assets/types/${types[1]}.png', width: 30),
        ],
      );
    }
    return Wrap(
      spacing: Styles.sidePadding,
      alignment: WrapAlignment.center,
      children: [
        Image.asset('assets/types/${types[0]}.png', width: 30),
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
}
