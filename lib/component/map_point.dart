import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:spirit_of_the_dungeon/component/adventure_map.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';
import 'package:spirit_of_the_dungeon/routes/adventure_page.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';
import 'package:spirit_of_the_dungeon/routes/data/adventure_data.dart';

class MapPoint extends SpriteComponent with TapCallbacks, HasGameRef<MainGame> {
  late AdventureData _adventureData;
  int id = 0;
  bool isActive = true;

  MapPoint({required this.id, required Vector2 mapPosition})
      : super(position: mapPosition);

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache('maps/bone_skull.png'));
    size = Vector2(50, 50);
    _adventureData = gameRef.adventureData;

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isActive) {
      _adventureData.currentMapPoint = this;
      gameRef.router.pushRoute(Route(BattleRoute.new));
      // gameRef.router.pushNamed('BattleRoute');
      // AdventurePage route = parent?.parent as AdventurePage;
      // route.enterBattleRoute();
    }
    super.onTapDown(event);
  }

  void disabled() {
    isActive = false;
    opacity = 0.6;
  }
}
