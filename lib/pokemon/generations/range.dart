class Range extends Object {
  final int low;
  final int high;

  Range({required this.high, required this.low});

  @override
  bool operator ==(Object other) {
    if(other is Range) {
      return low == other.low && high == other.high;
    }

    return false;
  }

  @override
  int get hashCode => super.hashCode;
}