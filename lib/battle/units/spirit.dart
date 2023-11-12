import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:spirit_of_the_dungeon/battle/units/character.dart';
import 'package:spirit_of_the_dungeon/data/damage_object.dart';
import 'package:spirit_of_the_dungeon/data/master_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_object.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';

class Spirit extends SpriteAnimationComponent with HasGameRef<SpiritOfDungeon> {
  static const double gravity = 200; // 중력 가속도
  static const double jumpVelocity = -400; // 점프 초기 속도
  static const double jumpHeight = 200; // 점프 높이

  final spiritPath = 'spirits/';
  late Character master;
  Character enemy;
  SpiritObject spiritObject;
  late SpiritData spiritData;

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

  Spirit({required this.spiritObject, required this.enemy});

  @override
  FutureOr<void> onLoad() {
    initSpiritData();
    final image = game.images.fromCache('$spiritPath${spiritData.imageName}');
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

  void initSpiritData() {
    SpiritData tempSpiritData = MasterData()
        .spirits
        .firstWhere((element) => element.id == spiritObject.spiritId);

    spiritData = tempSpiritData;
    // if (tempSpiritData != null) {
    //   spiritData = tempSpiritData;
    // } else {
    //   AssertionError('스피릿 생성 실패');
    // }
  }

  void startMoving() {
    targetPosition =
        enemy.position - (parent as PositionComponent).position.clone();
    startPosition = Vector2.zero();
    tempHeight = 50;
    slowdownFactor = 0.9;
    time = 0;
    goalTime = 0.5;
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

    // Combo bonus
    int comboBonus = 0;
    for (CombineBonusType comboBonusElement in spiritObject.combineBounsList) {
      switch (comboBonusElement) {
        case CombineBonusType.tripleFlush:
          comboBonus += 10;
          break;
        case CombineBonusType.straightFlush:
          comboBonus += 8;
          break;
        case CombineBonusType.triple:
          comboBonus += 6;
          break;
        case CombineBonusType.straight:
          comboBonus += 4;
          break;
        case CombineBonusType.flush:
          comboBonus += 1;
          break;
      }
    }

    // Upgrade bonus
    int upgradeFactor = gameRef.playerData.spiritUpgrades[spiritData.type]!;

    damageObject.ap =
        (master.ap * spiritData.ap + comboBonus + upgradeFactor).round();
    debugPrint('${damageObject.ap}');
    enemy.beAttacked(damageObject);
    removeFromParent();
  }
}
