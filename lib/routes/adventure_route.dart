import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';
import 'package:spirit_of_the_dungeon/routes/components/background.dart';
import 'package:spirit_of_the_dungeon/routes/components/rounded_button.dart';

class AdventureRoute extends Component with HasGameRef<MainGame> {
  late final RoundedButton _button1;
  late final TextComponent _logo;
  @override
  Future<void> onLoad() async {
    addAll([
      Background(const Color(0xff282828)),
      _logo = TextComponent(
        text: 'AdventureRoute',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontWeight: FontWeight.w800,
          ),
        ),
        anchor: Anchor.center,
      ),
      _button1 = RoundedButton(
        text: 'Battle Start',
        action: () => gameRef.router.pushNamed('BattleRoute'),
        color: const Color(0xffadde6c),
        borderColor: const Color(0xffedffab),
      ),
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 3);
    _button1.position = Vector2(size.x / 2, _logo.y + 80);
  }
}
