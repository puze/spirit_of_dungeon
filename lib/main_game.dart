import 'package:flame/game.dart';
import 'package:spirit_of_the_dungeon/adventure_route.dart';

class MainGame extends FlameGame {
  late final RouterComponent router;
  @override
  void onLoad() {
    add(router = RouterComponent(
        initialRoute: 'initialRoute',
        routes: {'routes': Route(AdventureRoute.new)}));
  }
}
