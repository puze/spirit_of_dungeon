import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';

class GameoverPage extends Component
    with HasGameRef<SpiritOfDungeon>, TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    add(RectangleComponent(
      size: game.size,
      paint: Paint()..color = const Color.fromARGB(164, 0, 0, 0),
      children: [
        TextComponent(
          text: 'Game Over',
          position: game.size / 2,
          scale: Vector2(2, 2),
          anchor: Anchor.center,
        )
      ],
    ));
    return super.onLoad();
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    game.router.pop();
    game.router.pop();
    game.router.pop();
    gameRef.resetGameData();
    super.onTapUp(event);
  }
}
