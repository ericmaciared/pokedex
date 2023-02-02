import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/firestore/firestore_adapter.dart';
import 'package:pokedex_app/firestore/user_data.dart';
import 'auth.dart';
import 'common/styles.dart';

class ProfilePage extends StatefulWidget {
  int numPokemons;

  ProfilePage({super.key, required this.numPokemons});

  @override
  _ProfilePageState createState() => _ProfilePageState(numPokemons);
}

class _ProfilePageState extends State<ProfilePage> {
  int numPokemons;

  _ProfilePageState(this.numPokemons);

  UserData user = UserData("Loading...", "Loading...");
  bool enabledName = false;
  bool editMode = false;
  String? errorMessage = "test error";

  @override
  void initState() {
    super.initState();
    FirestoreAdapter().getUserData(Auth().currentUser!).then((response) {
      setState(() {
        user = response!;
        enabledName = true;
      });
    });
  }

  Future<void> changeUserName(String name) async {
    User _user = Auth().currentUser!;
    await FirestoreAdapter().addName(_user, name);
    setState(() {
      user.name = name;
      editMode = false;
    });
  }

  Widget nameField(String name, bool enabled) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 const SizedBox(width: 6,),
                 Icon(Icons.person_outline, color: Styles.mainGray),
                 const SizedBox(width: 10,),
                 Styles.H4(name, Colors.black),
               ]
              ),
          IconButton(
            onPressed: () => setState(() => editMode = true),
            icon: Icon(Icons.mode_edit_outline, color: Styles.mainGray),
          )
        ]));
  }

  Widget editableNameField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          enabled: true,
          onSubmitted: (value) => changeUserName(value),
          decoration: InputDecoration(
            labelText: "Name",
            prefixIcon: Icon(
              Icons.person_outline,
              color: Styles.mainGray,
            ),
          ),
        ));
  }

  Widget emailField(String email, bool enabled) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          enabled: enabled,
          decoration: InputDecoration(
            labelText: email,
            prefixIcon: Icon(Icons.email_outlined, color: Styles.mainGray),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.tertiaryGray,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Styles.mainGray),
          leading: const BackButton()),
      body: Container(
          child: Column(
        children: <Widget>[
          Column(
            children: [
              const CircleAvatar(
                radius: 62,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/189/189001.png'),
              ),
              SizedBox(height: Styles.sidePadding),
              Styles.H4("$numPokemons Pokemons", Styles.mainGray),
            ],
          ),
          Container(
              margin: EdgeInsets.all(Styles.mainPadding),
              padding: EdgeInsets.all(Styles.sidePadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(children: <Widget>[
                editMode
                    ? editableNameField()
                    : nameField(user.name, enabledName),
                emailField(user.email, false),
              ])),
        ],
      )),
    );
  }
}
