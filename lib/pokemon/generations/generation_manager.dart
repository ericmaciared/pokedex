import 'package:pokedex_app/pokemon/generations/generations.dart';
import 'package:pokedex_app/pokemon/generations/range.dart';

class GenerationManager {
  late Range gen;
  late int id;

  GenerationManager({required this.gen, required this.id});

  GenerationManager.init() {
    this.gen = Generations.I();
    this.id = 1;
  }

  void next() {
    if(gen == Generations.VIII()) {
      return;
    }
    this.gen = Generations.get(++id)!;
  }

  void prev() {
    if(gen == Generations.I()) {
      return;
    }
    this.gen = Generations.get(--id)!;
  }
}