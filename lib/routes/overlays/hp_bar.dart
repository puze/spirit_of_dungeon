import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class HpBar extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  late RectangleComponent hpBarBackGround;
  late RectangleComponent hpBarGauge;

  @override
  FutureOr<void> onLoad() {
    initComponent();
    addAll([
      hpBarGauge,
      hpBarBackGround,
    ]);
    return super.onLoad();
  }

  void initComponent() {
    Vector2 screenSize = gameRef.size;
    hpBarBackGround = RectangleComponent(
      size: Vector2(screenSize.x / 2, 20),
      paint: BasicPalette.red.paint(),
    );
    hpBarGauge = RectangleComponent(
      size: Vector2(screenSize.x / 2, 20),
      paint: BasicPalette.gray.paint(),
    );
  }

  void resizeHpBar(double hpRatio) {
    Vector2 screenSize = gameRef.size;
    hpBarBackGround.size = Vector2(screenSize.x / 2 * hpRatio, 20);
  }
}