import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/common/widgets/form_button.dart';
import 'package:pokedex_app/common/widgets/input_field.dart';
import 'package:pokedex_app/register.dart';
import 'auth.dart';
import 'home.dart';
import 'common/styles.dart';

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
            builder: (_) => const HomePage()
        )
    );
  }


  Widget _pageArt() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Center(
        child: Container(
            height: 350,
            padding: const EdgeInsets.all(Styles.mainPadding),
            /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
            child: Image.asset('assets/4.png')),
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
            InputField.email(controller: _controllerEmail),
            const SizedBox(height: Styles.sidePadding),
            InputField.password(controller: _controllerPassword),
            _forgotPasswordButton(),
            FormButton(onPressed: ()=> login(), label: "Login"),
            _noAccountButton(),
            _errorLabel(errorMessage!)
          ],
        ),
      ),
    );
  }
}
