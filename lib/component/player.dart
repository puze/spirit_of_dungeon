import 'dart:async';
import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/component/character.dart';
import 'package:spirit_of_the_dungeon/component/enemy.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:spirit_of_the_dungeon/component/spirit.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';

class Player extends Character with HasGameRef<MainGame> {
  @override
  FutureOr<void> onLoad() async {
    final sprites = await gameRef.fromJSONAtlas(
        'Warrior-V1.3/Warrior/Individual Sprite/idle/idle.png',
        'animation_datas/idle.json');
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    size = size * 3;
    anchor = Anchor.center;
    return super.onLoad();
  }
}
