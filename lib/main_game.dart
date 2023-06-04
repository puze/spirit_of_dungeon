import 'package:flame/game.dart';
import 'package:spirit_of_the_dungeon/routes/adventure_route.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';
import 'package:spirit_of_the_dungeon/routes/main_route.dart';

class MainGame extends FlameGame {
  late final RouterComponent router;
  @override
  void onLoad() {
    add(router = RouterComponent(initialRoute: 'MainRoute', routes: {
      'MainRoute': Route(MainRoute.new),
      'AdventureRoute': Route(AdventureRoute.new),
      'BattleRoute': Route(BattleRoute.new),
    }));
  }
}
