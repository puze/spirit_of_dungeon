import 'package:flame/game.dart';
import 'package:spirit_of_the_dungeon/routes/adventure_page.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';
import 'package:spirit_of_the_dungeon/routes/data/adventure_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/player_data.dart';
import 'package:spirit_of_the_dungeon/routes/main_route.dart';
import 'package:spirit_of_the_dungeon/routes/overlays/hud.dart';

class MainGame extends FlameGame {
  late final RouterComponent router;
  final Hud hud = Hud();
  PlayerData playerData = PlayerData();
  AdventureData adventureData = AdventureData();

  @override
  void onLoad() {
    addAll([
      router = RouterComponent(initialRoute: 'MainRoute', routes: {
        'MainRoute': Route(MainRoute.new),
        'AdventureRoute': Route(AdventurePage.new),
        'BattleRoute': Route(BattleRoute.new),
      }),
      hud,
    ]);
    loadImages();
    debugMode = true;
  }

  void loadImages() async {
    await images.loadAll([
      'Free Pixel Effects Pack/16_sunburn_spritesheet.png',
      'maps/bone_skull.png',
      'maps/frame.png'
    ]);
  }
}
