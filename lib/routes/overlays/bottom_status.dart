import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class BottomStatus extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  late RectangleComponent bottomPartBackground;
  List<SpriteComponent> spiritsSprites = [];

  @override
  FutureOr<void> onLoad() async {
    initComponent();
    addAll([bottomPartBackground]);
    return super.onLoad();
  }

  void initComponent() {
    Vector2 screenSize = gameRef.size;
    Vector2 bottomPartBackgroundSize = Vector2(screenSize.x, screenSize.y / 5);
    bottomPartBackground = RectangleComponent(
      anchor: Anchor.topLeft,
      size: bottomPartBackgroundSize,
      position: Vector2(0, screenSize.y - bottomPartBackgroundSize.y),
      paint: Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.5)
        ..style = PaintingStyle.fill,
    );
  }

  void initSpirits() {}

  @override
  void onGameResize(Vector2 size) {
    Vector2 bottomPartBackgroundSize = Vector2(size.x, size.y / 5);
    bottomPartBackground
      ..size = bottomPartBackgroundSize
      ..position = Vector2(0, size.y - bottomPartBackgroundSize.y);
    super.onGameResize(size);
  }
}
