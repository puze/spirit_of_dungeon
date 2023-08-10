import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/rendering.dart';
import 'package:spirit_of_the_dungeon/routes/overlays/hp_bar.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class Hud extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  HpBar hpBar = HpBar();
  late RectangleComponent bottomPartBackground;
  double hpBarLength = 0;
  @override
  FutureOr<void> onLoad() async {
    Vector2 screenSize = gameRef.size;
    await super.onLoad();
    hpBar.position = Vector2(screenSize.x / 4, 30);
    Vector2 bottomPartBackgroundSize = Vector2(screenSize.x, screenSize.y / 5);
    bottomPartBackground = RectangleComponent(
      anchor: Anchor.topLeft,
      size: bottomPartBackgroundSize,
      position: Vector2(0, screenSize.y - bottomPartBackgroundSize.y),
      paint: Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.5)
        ..style = PaintingStyle.fill,
    );
    await addAll([hpBar, bottomPartBackground]);
  }

  @override
  void update(double dt) {
    hpBar.resizeHpBar(gameRef.playerData.hp / gameRef.playerData.maxHp);
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    Vector2 bottomPartBackgroundSize = Vector2(size.x, size.y / 5);
    bottomPartBackground
      ..size = bottomPartBackgroundSize
      ..position = Vector2(0, size.y - bottomPartBackgroundSize.y);
  }
}
