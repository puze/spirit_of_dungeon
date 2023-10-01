import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/routes/data/player_data.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class PlayerState extends Component with HasGameRef<SpiritOfDungeon> {
  void addSpirit(int spiritId) {
    PlayerData().spirits.add(spiritId);
    gameRef.hud.bottomStatus.loadSpirits();
  }
}
