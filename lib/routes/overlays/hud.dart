import 'dart:async';

import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/routes/data/master_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/player_data.dart';
import 'package:spirit_of_the_dungeon/routes/overlays/bottom_status.dart';
import 'package:spirit_of_the_dungeon/routes/overlays/hp_bar.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class Hud extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  HpBar hpBar = HpBar();
  BottomStatus bottomStatus = BottomStatus();
  double hpBarLength = 0;
  @override
  FutureOr<void> onLoad() async {
    Vector2 screenSize = gameRef.size;
    await super.onLoad();
    hpBar.position = Vector2(screenSize.x / 4, 30);
    await addAll([hpBar, bottomStatus]);
  }

  @override
  void update(double dt) {
    hpBar.resizeHpBar(PlayerData().hp / PlayerData().maxHp);
    super.update(dt);
  }
}
