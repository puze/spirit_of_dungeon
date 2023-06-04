class SpiritData {
  late Property property;
  late int rank;
  static Map<int, int> attackRankMap = {
    1: 10,
    2: 15,
    3: 18,
    4: 22,
    5: 26,
    6: 30
  };
  SpiritData({required this.property, required this.rank});
}

enum Property {
  water,
  fire,
  tree,
}
