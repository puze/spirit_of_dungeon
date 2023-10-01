import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TappableSrpite extends SpriteComponent with TapCallbacks {
  late void Function() tapUpAction;

  TappableSrpite({required this.tapUpAction, required Sprite sprite})
      : super(sprite: sprite);
  void setTapUp(void Function() action) {
    tapUpAction = action;
  }

  @override
  void onTapUp(TapUpEvent event) {
    tapUpAction();
    super.onTapUp(event);
  }
}
