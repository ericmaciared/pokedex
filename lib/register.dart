import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/common/widgets/form_button.dart';
import 'package:pokedex_app/common/widgets/input_field.dart';
import 'package:pokedex_app/firestore/firestore_adapter.dart';
import 'auth.dart';
import 'home.dart';
import 'login.dart';
import 'common/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordConfirmation =
  TextEditingController();

  String errorMessage = "";

  Future<bool> signUpWithUserAndEmail() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.message != null) {
          errorMessage = e.message!;
        }
      });
      return false;
    }
  }

  void openHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomePage()));
  }

  void cleanErrorMessage() {
    errorMessage = "";
  }

  Future<void> signUp() async {
    cleanErrorMessage();

    if (!passwordsMatch()) {
      setState(() {
        errorMessage = "The confirmation password does not match.";
      });
      return;
    }

    if (await signUpWithUserAndEmail()) {
      User? user = Auth().currentUser;
      if (user != null) {
        FirestoreAdapter adapter = FirestoreAdapter();
        await adapter.addEmail(user);
        await adapter.initCapturedPokemons(user);
        await adapter.addName(user, "Username");
      }
      openHomePage();
    }
  }

  bool passwordsMatch() {
    return _controllerPassword.text == _controllerPasswordConfirmation.text;
  }

  Widget _errorLabel(String message) {
    return Container(
        padding: EdgeInsets.all(Styles.sidePadding),
        child: Text.rich(TextSpan(
            text: message, style: const TextStyle(color: Colors.red))));
  }

  Widget _alreadyAccountButton() {
    return
      Container(
          padding: EdgeInsets.all(Styles.sidePadding),
          child: TextButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginPage())),
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
              )));
  }

  Widget _pageArt() {
    return
      Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Center(
          child: Container(
              height: 350,
              padding: const EdgeInsets.all(Styles.mainPadding),
              child: Image.asset('assets/841.png')),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _pageArt(),
            InputField.email(controller: _controllerEmail),
            const SizedBox(height: Styles.sidePadding),
            InputField.password(controller: _controllerPassword),
            const SizedBox(height: Styles.sidePadding),
            InputField.password(
                controller: _controllerPasswordConfirmation,
                label: "Confirm password"),
            _errorLabel(errorMessage),
            FormButton(onPressed: () => signUp(), label: "Sign Up"),
            _alreadyAccountButton(),
          ],
        ),
      ),
    );
  }
}
