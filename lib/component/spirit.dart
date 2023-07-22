import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:spirit_of_the_dungeon/component/character.dart';
import 'package:spirit_of_the_dungeon/component/enemy.dart';
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

  double attackMoveTime = 5;
  bool arrive = false;
  Vector2 targetDistance = Vector2.zero();
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
      time += dt;
      var timeScale = time != 0 ? time + 1 / time : dt;

      // x축 이동
      final distanceX = targetPosition.x - startPosition.x;
      position.x = startPosition.x + (targetDistance.x * time);

      // y축 이동 (포물선 운동)
      velocity.y -= 400 / pow(targetDistance.x, 2);
      final distancY = ((4 * tempHeight)) * (pow(time, 2) - time);
      position.y = startPosition.y + distancY;
      // debugPrint(
      //     'time:$time distancY:$distancY \n position.x:${position.x} position.y:${position.y}');

      if (position.x >= targetPosition.x) {
        arrive = true;
      }
    } else {
      endMoving();
    }
    super.update(dt);
  }

  void startMoving() {
    Vector2 destination =
        enemy.position - (parent as PositionComponent).position.clone();
    startPosition = Vector2.zero();
    // debugPrint('$startPosition, ${enemy.position}, $destination');
    targetPosition = destination;
    targetDistance = targetPosition - startPosition;
    tempHeight = 50;
    velocity.y = 200 / (targetPosition.x - startPosition.x);
    slowdownFactor = 0.9;
    time = 0;
    velocity = targetDistance.normalized() * startVelocity;
    arrive = false;
  }

  void endMoving() {
    DamageObject damageObject = DamageObject();
    damageObject.ap = master.ap;
    enemy.beAttacked(damageObject);
    removeFromParent();
  }
}
