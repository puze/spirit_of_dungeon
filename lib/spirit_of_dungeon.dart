import 'dart:convert';

import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:spirit_of_the_dungeon/routes/adventure_page.dart';
import 'package:spirit_of_the_dungeon/routes/battle_route.dart';
import 'package:spirit_of_the_dungeon/routes/data/adventure_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/player_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';
import 'package:spirit_of_the_dungeon/routes/main_route.dart';
import 'package:spirit_of_the_dungeon/routes/overlays/hud.dart';

class SpiritOfDungeon extends FlameGame {
  late final RouterComponent router;
  final Hud hud = Hud();
  PlayerData playerData = PlayerData();
  AdventureData adventureData = AdventureData();
  Map<int, SpiritData> spiritsMap = <int, SpiritData>{};

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
    loadSpiritsJsonData();
    debugMode = true;
  }

  void loadImages() async {
    await images.loadAll([
      'spirits/16_sunburn_spritesheet.png',
      'maps/bone_skull.png',
      'maps/frame.png'
    ]);
  }

  Future<void> loadSpiritsJsonData() async {
    String spiritsJsonString =
        await rootBundle.loadString('assets/datas/spirit.json');
    var spiritsJsonData =
        List<Map<String, dynamic>>.from(json.decode(spiritsJsonString));
    for (var element in spiritsJsonData) {
      SpiritData spiritData = SpiritData.fromJson(element);
      spiritsMap.addAll({spiritData.id!: spiritData});
    }
    // jsonData를 활용하여 필요한 작업 수행
  }
}
