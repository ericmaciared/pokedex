import 'package:flutter/material.dart';
import 'package:pokedex/login.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'package:pokedex/register.dart';
import 'home.dart';
import 'styles.dart';
import 'graphql.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    height: 350,
                    padding: EdgeInsets.all(Styles.mainPadding),
                    child: Image.asset('assets/134.png')),
              ),
            ),
            SizedBox(height: Styles.mainPadding),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: Styles.mainPadding),
                child: Styles.H1(
                    "Discover Pokémon, Build your Team", Colors.black)),
            SizedBox(height: Styles.sidePadding),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: Styles.mainPadding),
                child: Styles.H5(
                    "Browse through all pokemon, look at their data and become a pokemon master.",
                    Colors.black)),
            SizedBox(height: 2 * Styles.mainPadding),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginPage())),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shadowColor: Colors.redAccent,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                child: Styles.H5("Log In", Colors.white)),
            SizedBox(height: Styles.sidePadding),
            ElevatedButton(
              // TODO: Check pop / push configuration for navigator
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage())),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shadowColor: Colors.redAccent,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                child: Styles.H5("Sign Up", Colors.white)),
          ],
        ),
      ),
    );
  }
}
