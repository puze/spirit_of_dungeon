import 'package:flame/game.dart';
import 'package:spirit_of_the_dungeon/adventure/adventure_page.dart';
import 'package:spirit_of_the_dungeon/battle/battle_route.dart';
import 'package:spirit_of_the_dungeon/battle/gameover_route.dart';
import 'package:spirit_of_the_dungeon/data/adventure_data.dart';
import 'package:spirit_of_the_dungeon/data/master_data.dart';
import 'package:spirit_of_the_dungeon/data/player_data.dart';
import 'package:spirit_of_the_dungeon/data/player_state.dart';
import 'package:spirit_of_the_dungeon/main/main_route.dart';
import 'package:spirit_of_the_dungeon/overlays/hud.dart';
import 'package:spirit_of_the_dungeon/reward/reward_route.dart';

class SpiritOfDungeon extends FlameGame {
  late final RouterComponent router;
  final Hud hud = Hud();
  AdventureData adventureData = AdventureData();
  PlayerData playerData = PlayerData();
  PlayerState playerState = PlayerState();

  @override
  void onLoad() async {
    await loadImages();
    await MasterData().init();
    debugMode = true;
    addAll([
      router = RouterComponent(initialRoute: 'MainRoute', routes: {
        'MainRoute': Route(MainRoute.new),
        'AdventureRoute': Route(AdventurePage.new),
        'BattleRoute': Route(BattleRoute.new),
        'RewardRoute': RewardRoute(),
        'Pause': GameoverRoute(),
      }),
      playerState,
      hud,
    ]);
  }

  Future<void> loadImages() async {
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
      'ui/earth.png',
      'ui/fire.png',
      'ui/ice.png',
      'ui/Light.png',
    ]);
  }

  void resetGameData() {
    adventureData = AdventureData();
    playerData = PlayerData();
  }
}
