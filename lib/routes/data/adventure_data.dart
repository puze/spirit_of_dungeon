import 'dart:math';

import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/component/map_point.dart';

class AdventureData {
  bool isNeedRefreash = false;
  List<MapPoint> mapPoints = [];

  MapPoint? currentMapPoint;

  AdventureData() {
    initAdventureData();
  }

  void initAdventureData() {
    mapPoints = [
      MapPoint(id: 1, mapPosition: Vector2(50, 200)),
      // MapPoint(mapPosition: Vector2(120, 80)),
      // MapPoint(mapPosition: Vector2(110, 150)),
      // MapPoint(mapPosition: Vector2(100, 210)),
      // MapPoint(mapPosition: Vector2(130, 290)),
      // MapPoint(mapPosition: Vector2(190, 320)),
    ];

    currentMapPoint = mapPoints[0];
  }

  void openNextMapPoint() {
    Vector2? newMapPointPosition = currentMapPoint?.position.clone();
    if (newMapPointPosition == null) {
      return;
    }
    Random random = Random();
    newMapPointPosition.x += 70 + random.nextInt(30);
    newMapPointPosition.y += -25 + random.nextInt(50);
    // y 포지션 제한 두기
    if (newMapPointPosition.y <= 100) {
      newMapPointPosition.y = 100;
    } else if (newMapPointPosition.y >= 300) {
      newMapPointPosition.y = 300;
    }

    mapPoints.add(MapPoint(
        id: currentMapPoint!.id + 1, mapPosition: newMapPointPosition));
    currentMapPoint = mapPoints.last;
    isNeedRefreash = true;
  }
}
