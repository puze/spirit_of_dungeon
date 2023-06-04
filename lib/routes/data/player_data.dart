import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';

class PlayerData {
  late int hp;
  late List<SpiritData> spiritData;

  PlayerData() {
    hp = 100;
    spiritData = [SpiritData(property: Property.fire, rank: 1)];
  }
}
