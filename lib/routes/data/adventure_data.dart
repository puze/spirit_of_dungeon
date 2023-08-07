import 'package:flame/components.dart';
import 'package:spirit_of_the_dungeon/component/map_point.dart';

class AdventureData {
  bool isNeedRefreash = false;
  List<MapPoint> mapPoints = [
    MapPoint(mapPosition: Vector2(50, 50)),
    MapPoint(mapPosition: Vector2(120, 80)),
    MapPoint(mapPosition: Vector2(110, 150)),
    MapPoint(mapPosition: Vector2(100, 210)),
    MapPoint(mapPosition: Vector2(130, 290)),
    MapPoint(mapPosition: Vector2(190, 320)),
  ];

  MapPoint? currentMapPoint;
}
