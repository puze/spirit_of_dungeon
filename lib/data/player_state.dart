import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/data/master_data.dart';
import 'package:spirit_of_the_dungeon/data/player_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_object.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';

class PlayerState extends Component with HasGameRef<SpiritOfDungeon> {
  void initSpiritState() {
    applyCombinedBonus();
    gameRef.hud.bottomStatus.spiritsView.loadSpirits();
  }

  void addSpirit(int spiritId) {
    PlayerData().spirits.add(SpiritObject(spiritId: spiritId));
    applyCombinedBonus();
    gameRef.hud.bottomStatus.spiritsView.loadSpirits();
  }

  void applyCombinedBonus() {
    List<SpiritObject> spirits = PlayerData().spirits;
    if (spirits.length < 3) {
      return;
    }

    // 보너스 클리어후 재작성
    for (SpiritObject spiritElement in spirits) {
      spiritElement.combineBounsList.clear();
    }

    //tripleFlush, straightFlush, triple, straight, flush
    for (int i = 2; i < spirits.length; i++) {
      List<SpiritData> tempSpirits = [];
      for (int j = 2; j >= 0; j--) {
        tempSpirits.add(MasterData().getSpriritData(spirits[i - j].spiritId));
      }
      //tripleFlush
      if (tempSpirits[0].rank == tempSpirits[1].rank &&
          tempSpirits[1].rank == tempSpirits[2].rank &&
          tempSpirits[0].type == tempSpirits[1].type &&
          tempSpirits[1].type == tempSpirits[2].type) {
        for (int k = 0; k < 3; k++) {
          spirits[i - k].combineBounsList.add(CombineBonusType.tripleFlush);
        }
      }
      // straightFlush
      else if (tempSpirits[0].rank + 2 == tempSpirits[1].rank + 1 &&
          tempSpirits[1].rank + 1 == tempSpirits[2].rank &&
          tempSpirits[0].type == tempSpirits[1].type &&
          tempSpirits[1].type == tempSpirits[2].type) {
        for (int k = 0; k < 3; k++) {
          spirits[i - k].combineBounsList.add(CombineBonusType.straightFlush);
        }
      }
      // triple
      else if (tempSpirits[0].rank == tempSpirits[1].rank &&
          tempSpirits[1].rank == tempSpirits[2].rank) {
        for (int k = 0; k < 3; k++) {
          spirits[i - k].combineBounsList.add(CombineBonusType.triple);
        }
      }
      // straight
      else if (tempSpirits[0].rank + 2 == tempSpirits[1].rank + 1 &&
          tempSpirits[1].rank + 1 == tempSpirits[2].rank) {
        for (int k = 0; k < 3; k++) {
          spirits[i - k].combineBounsList.add(CombineBonusType.straight);
        }
      }
      // straight
      else if (tempSpirits[0].type == tempSpirits[1].type &&
          tempSpirits[1].type == tempSpirits[2].type) {
        for (int k = 0; k < 3; k++) {
          spirits[i - k].combineBounsList.add(CombineBonusType.flush);
        }
      }
    }
  }
}
