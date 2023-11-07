class SpiritObject {
  SpiritObject({required this.spiritId});
  int spiritId;
  List<CombineBonusType> combineBounsList = [];
}

enum CombineBonusType { tripleFlush, straightFlush, triple, straight, flush }
