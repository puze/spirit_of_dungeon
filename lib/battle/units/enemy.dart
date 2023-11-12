import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:spirit_of_the_dungeon/battle/units/character.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';

class Enemy extends Character with HasGameRef<SpiritOfDungeon> {
  @override
  FutureOr<void> onLoad() async {
    final sprites = await gameRef.fromJSONAtlas(
        'character/enemy_idle.png', 'animation_datas/enemy_idle.json');
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    size = size * 3;
    anchor = Anchor.center;

    return super.onLoad();
  }

  @override
  void initData() {
    //TODO:데이터화
    hp = 100;
    ap = 1000;
  }
}
