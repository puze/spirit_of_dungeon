import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';
import 'package:spirit_of_the_dungeon/component/adventure_map.dart';
import 'package:spirit_of_the_dungeon/spirit_of_dungeon.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';
import 'package:spirit_of_the_dungeon/routes/components/background.dart';
import 'package:spirit_of_the_dungeon/routes/components/rounded_button.dart';

class AdventurePage extends Component with HasGameRef<SpiritOfDungeon> {
  // late final RoundedButton _button1;
  late final TextComponent _logo;
  late final RectangleComponent test;
  late AdventureMap adventureMap;

  @override
  Future<void> onLoad() async {
    initComponents();
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
      // _button1 = RoundedButton(
      //   text: 'Battle Start',
      //   // action: () => gameRef.router.pushNamed('BattleRoute'),
      //   action: () {
      //     add(BattleRoute());
      //   },
      //   color: const Color(0xffadde6c),
      //   borderColor: const Color(0xffedffab),
      // ),
      adventureMap,
      // test = RectangleComponent(
      //   position: Vector2.zero(),
      //   size: (gameRef.size / 2),
      //   paint: BasicPalette.red.paint(),
      // )
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 3);
    // _button1.position = Vector2(size.x / 2, _logo.y + 80);

    adventureMap.anchor = Anchor.center;
    adventureMap.position = size / 2;
    // Vector2 mapSize = adventureMap.size;
    // adventureMap.position =
    //     Vector2(size.x / 2 - mapSize.x / 2, size.y / 2 - mapSize.y / 2);
  }

  void initComponents() {
    adventureMap = AdventureMap();
  }
}
