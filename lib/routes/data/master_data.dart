import 'dart:convert';

import 'package:darq/darq.dart';
import 'package:flutter/services.dart';
import 'package:spirit_of_the_dungeon/routes/data/player_data.dart';
import 'package:spirit_of_the_dungeon/routes/data/spirit_data.dart';

class MasterData {
  static final MasterData _instance = MasterData._internal();

  List<SpiritData> spirits = [];
  PlayerData playerData = PlayerData();

  MasterData._internal();
  late int sumSpiritRewardRatio;
  factory MasterData() {
    return _instance;
  }

  Future<void> init() async {
    String spiritsJsonString =
        await rootBundle.loadString('assets/datas/spirit.json');
    var spiritsJsonData =
        List<Map<String, dynamic>>.from(json.decode(spiritsJsonString));
    for (var element in spiritsJsonData) {
      SpiritData spiritData = SpiritData.fromJson(element);
      spirits.add(spiritData);
    }

    sumSpiritRewardRatio =
        MasterData().spirits.sum((spirit) => spirit.spiritRewardRatio!);
  }
}
