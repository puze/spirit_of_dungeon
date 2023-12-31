import 'dart:async';

import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';
import 'package:spirit_of_the_dungeon/overlays/bottom_status.dart';
import 'package:spirit_of_the_dungeon/overlays/hp_bar.dart';

class Hud extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  HpBar hpBar = HpBar();
  BottomStatus bottomStatus = BottomStatus();
  double hpBarLength = 0;
  @override
  FutureOr<void> onLoad() async {
    Vector2 screenSize = gameRef.size;
    gameRef.playerState.applyCombinedBonus();
    await super.onLoad();
    hpBar.position = Vector2(screenSize.x / 4, 30);
    await addAll([hpBar, bottomStatus]);
    bottomStatus.anchor = Anchor.bottomLeft;
    // bottomStatus.position = Vector2(0, screenSize.y - screenSize.y / 5);
    bottomStatus.position =
        Vector2(0, screenSize.y - bottomStatus.bottomPartBackground.size.y);
  }

  @override
  void update(double dt) {
    hpBar.resizeHpBar(gameRef.playerData.hp / gameRef.playerData.maxHp);
    super.update(dt);
  }
}
