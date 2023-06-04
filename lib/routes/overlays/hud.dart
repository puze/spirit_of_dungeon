import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';

class Hud extends PositionComponent with HasGameRef<MainGame> {
  late _AnchoredRectangle _redAnchoredRectangle;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _redAnchoredRectangle = _AnchoredRectangle(
      size: size / 4,
      position: size / 2,
      paint: BasicPalette.red.paint(),
    );

    await addAll([_redAnchoredRectangle]);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}

class _AnchoredRectangle extends RectangleComponent with TapCallbacks {
  _AnchoredRectangle({
    super.position,
    super.size,
    super.paint,
  });

  @override
  void onTapDown(TapDownEvent event) {
    var index = Anchor.values.indexOf(anchor) + 1;
    if (index == Anchor.values.length) {
      index = 0;
    }
    anchor = Anchor.values.elementAt(index);
    super.onTapDown(event);
  }
}
