import 'package:spirit_of_the_dungeon/data/spirit_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_object.dart';

class PlayerData {
  //consturctor
  PlayerData() {
    initPlayerData();
  }

  late int hp;
  int maxHp = 1000;
  List<SpiritObject> spirits = [];

  Map<SpiritType, int> spiritUpgrades = {
    SpiritType.fire: 1,
    SpiritType.tree: 1,
    SpiritType.water: 1
  };

  void initPlayerData() {
    hp = 1000;
    spirits.clear();
    for (int i = 0; i < 3; i++) {
      spirits.add(SpiritObject(spiritId: 1));
    }
  }
}
