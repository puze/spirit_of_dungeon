class SpiritData {
  int? id;
  String? name;
  Type? type;
  int? rank;
  double? ap;
  String? imageName;

  SpiritData(
      {this.id, this.name, this.type, this.rank, this.ap, this.imageName});

  SpiritData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = getStatusFromJson(json['type']);
    rank = json['rank'];
    ap = (json['ap'] as int).toDouble();
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['rank'] = rank;
    data['ap'] = ap;
    data['imageName'] = imageName;
    return data;
  }

  Type getStatusFromJson(String typeString) {
    switch (typeString) {
      case 'water':
        return Type.water;
      case 'fire':
        return Type.fire;
      case 'tree':
        return Type.tree;
      default:
        throw ArgumentError("Unknown status: $typeString");
    }
  }
}

enum Type {
  water,
  fire,
  tree,
}
