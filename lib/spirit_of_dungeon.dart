import 'package:flame/game.dart';
import 'package:spirit_of_the_dungeon/routes/adventure_page.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';
import 'package:spirit_of_the_dungeon/routes/data/adventure_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/master_data.dart';
import 'package:spirit_of_the_dungeon/routes/main_route.dart';
import 'package:spirit_of_the_dungeon/routes/overlays/hud.dart';
import 'package:spirit_of_the_dungeon/routes/reward_route.dart';

class SpiritOfDungeon extends FlameGame {
  late final RouterComponent router;
  final Hud hud = Hud();
  AdventureData adventureData = AdventureData();

  @override
  void onLoad() {
    addAll([
      router = RouterComponent(initialRoute: 'MainRoute', routes: {
        'MainRoute': Route(MainRoute.new),
        'AdventureRoute': Route(AdventurePage.new),
        'BattleRoute': Route(BattleRoute.new),
        'RewardRoute': RewardRoute()
      }),
      hud,
    ]);
    loadImages();
    MasterData().init();
    debugMode = true;
  }

  void loadImages() async {
    await images.loadAll([
      'spirits/16_sunburn_spritesheet.png',
      'spirits/17_felspell_spritesheet.png',
      'spirits/19_freezing_spritesheet.png',
      'maps/bone_skull.png',
      'maps/frame.png',
      'rewards/chest_full_open_anim_f0.png',
      'rewards/item_28.png',
      'rewards/blue_book.png',
      'rewards/green_book.png',
      'rewards/red_book.png',
    ]);
  }
}
