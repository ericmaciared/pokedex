import 'package:flutter/material.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'home.dart';
import 'login.dart';
import 'styles.dart';
import 'graphql.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                    child: Image.asset('assets/841.png')),
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
            const Padding(
              padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(height: Styles.mainPadding),
            ElevatedButton(
                onPressed: () =>
                // TODO: ADD VALIDATING FUNCTION
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LoginPage())),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shadowColor: Colors.redAccent,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                child: Styles.H5("Sign Up", Colors.white)),
            Container(
                padding: EdgeInsets.all(Styles.sidePadding),
                child: TextButton(
                    onPressed: () =>
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage())),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Log In',
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
