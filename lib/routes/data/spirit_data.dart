class SpiritData {
  late int id;
  late String name;
  late SpiritType type;
  late int rank;
  late double ap;
  late int spiritRewardRatio;
  late String imageName;
  late String uiImageName;

  SpiritData();

  SpiritData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = getStatusFromJson(json['type']);
    rank = json['rank'];
    ap = (json['ap'] as int).toDouble();
    spiritRewardRatio = json['spiritRewardRatio'];
    imageName = json['imageName'];
    uiImageName = json['uiImageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['rank'] = rank;
    data['ap'] = ap;
    data['spiritRewardRatio'] = spiritRewardRatio;
    data['imageName'] = imageName;
    data['uiImageName'] = uiImageName;
    return data;
  }

  SpiritType getStatusFromJson(String typeString) {
    switch (typeString) {
      case 'water':
        return SpiritType.water;
      case 'fire':
        return SpiritType.fire;
      case 'tree':
        return SpiritType.tree;
      default:
        throw ArgumentError("Unknown status: $typeString");
    }
  }
}

enum SpiritType {
  water,
  fire,
  tree,
}
