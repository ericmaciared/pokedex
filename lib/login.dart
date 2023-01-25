import 'package:flutter/material.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'home.dart';
import 'styles.dart';
import 'graphql.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/4.png')),
              ),
            ),
            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(0, 0, Styles.sidePadding, 0),
                child: TextButton(
                  onPressed: null,
                  child: Styles.H5("Forgot your password?", Colors.red),
                )),
            ElevatedButton(
                onPressed: () =>
                    // TODO: ADD VALIDATING FUNCTION
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomePage(
                                  title: 'Pokedex',
                                ))),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shadowColor: Colors.redAccent,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal),
                ),
                child: Styles.H5("Login", Colors.white)),
            Container(
                padding: EdgeInsets.all(Styles.sidePadding),
                child: TextButton(
                    onPressed: () =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomePage(
                              title: 'Pokedex',
                            ))),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}