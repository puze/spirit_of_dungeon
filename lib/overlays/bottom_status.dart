import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';
import 'package:spirit_of_the_dungeon/overlays/spirits_view.dart';

class BottomStatus extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  late RectangleComponent bottomPartBackground;
  late ClipComponent clipComponent;
  late SpiritsView spiritsView;

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
      paint: Paint()
        ..color = const Color.fromRGBO(0, 0, 0, 0.5)
        ..style = PaintingStyle.fill,
      priority: 1,
    );

    clipComponent = ClipComponent.rectangle(
        size: Vector2(screenSize.x * 4 / 5, screenSize.y * 2 / 3 / 5),
        position: Vector2(screenSize.x / 2, 0),
        anchor: Anchor.topCenter,
        priority: 10);
    spiritsView = SpiritsView();
    clipComponent.add(spiritsView);
    add(clipComponent);
  }

  @override
  void onGameResize(Vector2 size) {
    Vector2 bottomPartBackgroundSize = Vector2(size.x, size.y / 5);
    bottomPartBackground.size = bottomPartBackgroundSize;
    super.onGameResize(size);
  }
}
