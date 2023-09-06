import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';

class PlayerData {
  static final PlayerData _instance = PlayerData._internal();

  //consturctor
  PlayerData._internal() {
    hp = 100;
    for (int i = 0; i < 3; i++) {
      spirits.add(1);
    }
  }

  factory PlayerData() {
    return _instance;
  }

  late int hp;
  int maxHp = 100;
  List<int> spirits = [];
  Map<SpiritType, int> spiritUpgrades = {
    SpiritType.fire: 1,
    SpiritType.tree: 1,
    SpiritType.water: 1
  };
}
