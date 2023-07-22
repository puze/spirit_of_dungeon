import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:flutter/rendering.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';

class Hud extends PositionComponent with HasGameRef<MainGame> {
  late RectangleComponent _redAnchoredRectangle;
  late RectangleComponent bottomPartBackground;
  @override
  FutureOr<void> onLoad() async {
    Vector2 screenSize = gameRef.size;
    await super.onLoad();
    _redAnchoredRectangle = RectangleComponent(
      anchor: Anchor.topCenter,
      size: Vector2(screenSize.x / 2, 20),
      position: Vector2(screenSize.x / 2, 30),
      paint: BasicPalette.red.paint(),
    );
    Vector2 bottomPartBackgroundSize = Vector2(screenSize.x, screenSize.y / 5);
    bottomPartBackground = RectangleComponent(
      anchor: Anchor.topLeft,
      size: bottomPartBackgroundSize,
      position: Vector2(0, screenSize.y - bottomPartBackgroundSize.y),
      paint: Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.5)
        ..style = PaintingStyle.fill,
    );
    await addAll([_redAnchoredRectangle, bottomPartBackground]);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    super.onGameResize(size);
    _redAnchoredRectangle
      ..size = Vector2(size.x / 2, 20)
      ..position = Vector2(size.x / 2, 30);
    Vector2 bottomPartBackgroundSize = Vector2(size.x, size.y / 5);
    bottomPartBackground
      ..size = bottomPartBackgroundSize
      ..position = Vector2(0, size.y - bottomPartBackgroundSize.y);
  }
}
