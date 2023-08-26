import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';

class PlayerData {
  late int hp;
  int maxHp = 100;
  List<int> spirits = [];
  Map<SpiritType, int> spiritUpgrades = {
    SpiritType.fire: 1,
    SpiritType.tree: 1,
    SpiritType.water: 1
  };

  PlayerData() {
    hp = 100;
    for (int i = 0; i < 3; i++) {
      spirits.add(1);
    }
  }
}
