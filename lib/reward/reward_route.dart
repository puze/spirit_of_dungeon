import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:spirit_of_the_dungeon/reward/reward_page.dart';

class RewardRoute extends ValueRoute<bool> {
  RewardRoute() : super(transparent: true, value: false);

  @override
  Component build() {
    return RewardPage();
  }

  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime()
      ..addRenderEffect(
        PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0),
      );
  }

  @override
  void onPop(Route nextRoute) {
    nextRoute
      ..resumeTime()
      ..removeRenderEffect();
  }
}
