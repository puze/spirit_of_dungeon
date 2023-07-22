import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:spirit_of_the_dungeon/component/spirit.dart';
import 'package:spirit_of_the_dungeon/routes/data/damage_object.dart';

class Character extends SpriteAnimationComponent {
  int hp = 0;
  int ap = 0;

  List<Spirit> spirits = [];
  int currentSpiritNum = 0;
  double cooltime = 0;
  bool isAttackTime = false;
  bool isDie = false;

  @override
  FutureOr<void> onLoad() {
    isDie = false;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isAttackTime) {
      if (cooltime <= 0) {
        if (currentSpiritNum < spirits.length) {
          attack();
          cooltime = 0.05;
        } else {
          isAttackTime = false;
        }
      }
      cooltime -= dt;
    }
    for (int i = 0; i < spirits.length; i++) {}
  }

  void beAttacked(DamageObject damageObject) {
    hp -= damageObject.ap;
    if (hp <= 0) {
      die();
    }
  }

  void attack() {
    Spirit currentSpirit = spirits[currentSpiritNum];
    add(currentSpirit);
    currentSpirit.startMoving();
    currentSpiritNum++;
  }

  void attackStart() {
    isAttackTime = true;
    currentSpiritNum = 0;
  }

  void setSpirit(Character enemy) {
    Spirit spirit = Spirit(enemy: enemy);
    spirits.add(spirit);
  }

  void die() {
    isDie = true;
    debugPrint('$this is died');
  }
}
