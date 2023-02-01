import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_app/firestore/user_data.dart';

class FirestoreAdapter {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  FirestoreAdapter();

  Future<bool> addEmail(User user) async {
    bool success = true;
    await db.collection("users").doc(user.uid).set(
        {"email": user.email}).onError((error, stackTrace) => success = false);

    return success;
  }

  Future<bool> addName(User user, String name) async {
    bool success = true;
    await db.collection("users").doc(user.uid).update(
        {"name": name}).onError((error, stackTrace) => success = false);

    return success;
  }

  Future<bool> initCapturedPokemons(User user) async {
    bool success = true;
    CollectionReference pokemonsCollection =
    db.collection("users").doc(user.uid).collection("pokemons");

    await pokemonsCollection.doc("captured").set({"all" : []})
        .onError((error, stackTrace) => success = false);

    return success;
  }

  Future<bool> addPokemon(User user, String pokemonId) async {
    bool success = true;
    CollectionReference pokemonsCollection =
        db.collection("users").doc(user.uid).collection("pokemons");

    DocumentReference captured = pokemonsCollection.doc("captured");

    await captured.update({
      "all": FieldValue.arrayUnion([pokemonId])
    }).onError((error, stackTrace)  {
      success = false;
    });

    return success;
  }

  Future<List<String>> getPokemons(User user) async {
    List<String> pokemons = [];

    await db
        .collection("users")
        .doc(user.uid)
        .collection("pokemons")
        .doc("captured")
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      pokemons = [...data["all"]];
    });

    return pokemons;
  }

  Future<UserData?> getUserData(User user) async {
    UserData? _user;

    await db
    .collection("users")
    .doc(user.uid)
    .get()
    .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      _user = UserData(data["name"], data["email"]);
    });

    return _user;
  }
}
