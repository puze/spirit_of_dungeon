import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:spirit_of_the_dungeon/battle/gameover_page.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';

class GameoverRoute extends Route with HasGameRef<SpiritOfDungeon> {
  GameoverRoute() : super(GameoverPage.new, transparent: true);

  @override
  void onPush(Route? previousRoute) {
    previousRoute!.addRenderEffect(
      PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0),
    );
  }

  @override
  void onPop(Route nextRoute) {
    nextRoute.removeRenderEffect();
  }
}
