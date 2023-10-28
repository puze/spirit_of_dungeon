class SpiritObject {
  SpiritObject({required this.spiritId});
  int spiritId;
  List<CombineBonusType> combineBouns = [];
}

enum CombineBonusType { tripleFlush, straightFlush, triple, straight, flush }
