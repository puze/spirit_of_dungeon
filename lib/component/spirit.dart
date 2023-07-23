import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:spirit_of_the_dungeon/component/character.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';
import 'package:spirit_of_the_dungeon/routes/data/damage_object.dart';

class Spirit extends SpriteAnimationComponent with HasGameRef<MainGame> {
  static const double gravity = 200; // 중력 가속도
  static const double jumpVelocity = -400; // 점프 초기 속도
  static const double jumpHeight = 200; // 점프 높이

  late Character master;
  Character enemy;

  Vector2 velocity = Vector2.zero();
  Vector2 startPosition = Vector2.zero();
  Vector2 targetPosition = Vector2.zero();
  double time = 0;
  double goalTime = 0;

  double attackMoveTime = 5;
  bool arrive = false;
  double tempHeight = 0;
  double slowdownFactor = 0;
  double startVelocity = 0;

  bool isPresent = false;

  Spirit({required this.enemy});

  @override
  FutureOr<void> onLoad() {
    final image = game.images
        .fromCache('Free Pixel Effects Pack/16_sunburn_spritesheet.png');
    animation = SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
            amount: 61,
            amountPerRow: 8,
            stepTime: 0.1,
            textureSize: Vector2(100, 100),
            loop: true));

    master = (parent as Character);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!arrive) {
      updateMove(dt);
    } else {
      endMoving();
    }
    super.update(dt);
  }

  void startMoving() {
    targetPosition =
        enemy.position - (parent as PositionComponent).position.clone();
    startPosition = Vector2.zero();
    tempHeight = 50;
    slowdownFactor = 0.9;
    time = 0;
    goalTime = 1;
    arrive = false;
  }

  void updateMove(double dt) {
    time += dt;
    // x축 이동
    position.x = (targetPosition.x.abs() / goalTime) * time; // scale문제로 절대값 적용
    // y축 이동 (포물선 운동)
    position.y = (4 * tempHeight) / pow(goalTime, 2) * time * (time - goalTime);

    if (goalTime <= time) {
      arrive = true;
    }
  }

  void endMoving() {
    DamageObject damageObject = DamageObject();
    damageObject.ap = master.ap;
    enemy.beAttacked(damageObject);
    removeFromParent();
  }
}
