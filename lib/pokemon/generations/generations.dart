import 'package:pokedex_app/pokemon/generations/range.dart';

class Generations {
  static const _I = 150;
  static const _II = 251;
  static const _III = 386;
  static const _IV = 493;
  static const _V = 649;
  static const _VI = 721;
  static const _VII = 809;
  static const _VIII = 905;

  Generations();

  static Range? get(int gen) {
    List<int> generations = [_I, _II, _III, _IV, _V, _VI, _VII, _VIII];
    Range? range;

    if (gen == 1) {
      range = Range(low: 0, high: generations.elementAt(gen-1));
    } else if (gen > 1 && gen <= 8) {
      range = Range(
          low: generations.elementAt(gen - 1 - 1) + 1,
          high: generations.elementAt(gen - 1));
    } else {
      range = null;
    }

    return range;
  }

  static Range I() {
    return get(1)!;
  }

  static Range II() {
    return get(2)!;
  }

  static Range III() {
    return get(3)!;
  }

  static Range IV() {
    return get(4)!;
  }

  static Range V() {
    return get(5)!;
  }

  static Range VI() {
    return get(6)!;
  }

  static Range VII() {
    return get(7)!;
  }

  static Range VIII() {
    return get(8)!;
  }
}
