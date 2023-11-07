import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class GameoverPage extends Component {
  @override
  void onGameResize(Vector2 size) {
    RectangleComponent.fromRect(Rect.fromLTRB(0, 0, size.x, size.y)).paint =
        Paint()..color = const Color.fromARGB(159, 0, 0, 0);
    super.onGameResize(size);
  }
}
