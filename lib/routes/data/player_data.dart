import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';

class PlayerData {
  late int hp;
  int maxHp = 100;
  List<int> spirits = [];

  PlayerData() {
    hp = 100;
    for (int i = 0; i < 10; i++) {
      spirits.add(1);
    }
  }
}
