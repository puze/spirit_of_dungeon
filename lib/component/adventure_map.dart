import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:spirit_of_the_dungeon/routes/data/adventure_data.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';

class AdventureMap extends SpriteComponent with HasGameRef<SpiritOfDungeon> {
  double mapScale = 0.5;
  late AdventureData adventureData;
  @override
  FutureOr<void> onLoad() {
    adventureData = gameRef.adventureData;
    sprite = Sprite(Flame.images.fromCache('maps/frame.png'));
    size = Vector2(1280, 904) * mapScale;
    // add(SpriteComponent(
    //   sprite: Sprite(Flame.images.fromCache('maps/frame.png')),
    //   size: Vector2(1280, 904) * mapScale,
    // ));
    addAll(adventureData.mapPoints);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (adventureData.isNeedRefreash) {
      add(adventureData.currentMapPoint!);
      adventureData.isNeedRefreash = false;
    }
    super.update(dt);
  }
}
