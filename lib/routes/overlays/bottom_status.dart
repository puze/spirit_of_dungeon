import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:spirit_of_the_dungeon/routes/data/master_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/player_data.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class BottomStatus extends PositionComponent with HasGameRef<SpiritOfDungeon> {
  late RectangleComponent bottomPartBackground;
  List<Component> spiritsSprites = [];

  @override
  FutureOr<void> onLoad() async {
    initComponent();
    addAll([bottomPartBackground]);
    loadSpirits();
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
    );
  }

  void loadSpirits() {
    removeAll(spiritsSprites);
    int index = 0;
    double firstIntervale = 20;
    double spritesInterval = 70;
    double spriteSize = 50;
    for (var spiritId in PlayerData().spirits) {
      var spirit = MasterData().getSpriritData(spiritId);
      spiritsSprites.add(SpriteComponent(
          sprite: Sprite(Flame.images.fromCache('ui/${spirit.uiImageName}')),
          position: Vector2(index * spritesInterval + firstIntervale, 20),
          size: Vector2(spriteSize, spriteSize)));
      spiritsSprites.add(TextComponent(
          anchor: Anchor.bottomRight,
          text: '${spirit.rank}',
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 23,
              color: Color.fromARGB(255, 215, 218, 47),
              backgroundColor: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          position: Vector2(
              index * spritesInterval + firstIntervale + spriteSize,
              firstIntervale + spriteSize)));
      index++;
    }
    addAll(spiritsSprites);
  }

  @override
  void onGameResize(Vector2 size) {
    Vector2 bottomPartBackgroundSize = Vector2(size.x, size.y / 5);
    bottomPartBackground.size = bottomPartBackgroundSize;
    super.onGameResize(size);
  }
}
