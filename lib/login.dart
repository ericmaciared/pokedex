import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokemon/widgets/pokemon_grid.dart';
import 'auth.dart';
import 'package:pokedex/register.dart';
import 'home.dart';
import 'styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<bool> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      return true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      return false;
    }
  }

  Future<void> login() async {
    if(await signInWithEmailAndPassword()) {
      openHomePage();
    }
  }

  void openHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const HomePage(
              title: 'Pokedex',
            )
        )
    );
  }


  Widget _pageArt() {
    return Padding(
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
    );
  }

  Widget _emailField(TextEditingController controller) {
    return Padding(
      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter valid email id as abc@gmail.com'),
      ),
    );
  }

  Widget _passwordField(TextEditingController controller) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 30),
      //padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        obscureText: true,
        controller: controller,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter secure password'),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: Styles.mainPadding),
        child: TextButton(
          onPressed: null,
          child: Styles.H5("Forgot your password?", Colors.red),
        ));
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => login,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          shadowColor: Colors.redAccent,
          minimumSize: Size(250, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 10, fontStyle: FontStyle.normal),
        ),
        child: Styles.H5("Login", Colors.white));
  }

  Widget _errorLabel(String message) {
    return Container(
        padding: EdgeInsets.all(Styles.sidePadding),
        child: Text.rich(TextSpan(
            text: message,
            style: const TextStyle(color: Colors.red))
        )
    );
  }

  Widget _noAccountButton() {
    return Container(
        padding: EdgeInsets.all(Styles.sidePadding),
        child: TextButton(
            onPressed: () => Navigator.push(
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
            ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _pageArt(),
            _emailField(_controllerEmail),
            SizedBox(height: Styles.sidePadding),
            _passwordField(_controllerPassword),
            _forgotPasswordButton(),
            _loginButton(context),
            _noAccountButton(),
            _errorLabel(errorMessage!)
          ],
        ),
      ),
    );
  }
}
