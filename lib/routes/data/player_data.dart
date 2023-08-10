import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';

class PlayerData {
  late int hp;
  int maxHp = 100;
  Map<String, int> spiritMap = {};
  late List<SpiritData> spiritData;

  PlayerData() {
    hp = 100;
    spiritData = [SpiritData(property: Property.fire, rank: 1)];
  }
}
