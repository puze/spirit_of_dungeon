import 'dart:async';

import 'package:darq/darq.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:spirit_of_the_dungeon/data/master_data.dart';
import 'package:spirit_of_the_dungeon/data/player_data.dart';

class SpiritsView extends RectangleComponent with DragCallbacks {
  List<Component> spiritsSprites = [];
  final double firstIntervale = 20;
  final double spritesInterval = 70;
  final double spriteSize = 50;
  late double parentWidth;
  double currentSize = 0;

  @override
  FutureOr<void> onLoad() {
    initComponent();
    loadSpirits();
    return super.onLoad();
  }

  void initComponent() {
    parentWidth = (parent as PositionComponent).size.x;
    size.y = (parent as PositionComponent).size.y;
    paint = Paint()..color = const Color.fromARGB(59, 255, 191, 0);
    // paint = Paint()..color = Colors.transparent;
  }

  void loadSpirits() {
    removeAll(spiritsSprites);
    int index = 0;
    for (var spiritObject in PlayerData().spirits) {
      var spirit = MasterData().getSpriritData(spiritObject.spiritId);
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
      if (spiritObject.combineBounsList.isNotEmpty) {
        spiritsSprites.add(SpriteComponent(
            sprite: Sprite(Flame.images.fromCache('ui/Light.png')),
            position: Vector2(index * spritesInterval + firstIntervale + 20, 7),
            size: Vector2(10, 10)));
      }
      index++;
    }
    addAll(spiritsSprites);
    calCurrentSize();
  }

  void calCurrentSize() {
    currentSize =
        (firstIntervale) + (PlayerData().spirits.count() * spritesInterval);
    size.x = currentSize;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    Vector2 targetPosition = Vector2(position.x + event.delta.x, position.y);
    // targetPosition.x = targetPosition.x >= 0 ? targetPosition.x : 0;
    double diffrence = currentSize - parentWidth;
    if (diffrence >= 0) {
      targetPosition.x =
          targetPosition.x >= -diffrence ? targetPosition.x : -diffrence;
      targetPosition.x = targetPosition.x >= 0 ? 0 : targetPosition.x;
      position = targetPosition;
    }
    super.onDragUpdate(event);
  }
}
