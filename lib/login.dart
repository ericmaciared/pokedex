import 'package:flutter/material.dart';
import 'package:pokedex_app/register.dart';
import 'home.dart';
import 'styles.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            SizedBox(height: Styles.sidePadding),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: Styles.mainPadding),
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
                            builder: (_) => const HomePage())),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shadowColor: Colors.redAccent,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                child: Styles.H5("Login", Colors.white)),
            Container(
                padding: EdgeInsets.all(Styles.sidePadding),
                child: TextButton(
                    onPressed: () =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterPage())),
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
