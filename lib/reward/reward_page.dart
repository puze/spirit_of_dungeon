import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:spirit_of_the_dungeon/data/master_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_data.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';
import 'package:spirit_of_the_dungeon/tools/tapperble_sprite.dart';

class RewardPage extends Component
    with TapCallbacks, HasGameRef<SpiritOfDungeon> {
  late TappableSrpite rewardSpiritSprite;
  late TappableSrpite rewardUpgradeSprite;
  late TappableSrpite fireUpgradeSprite;
  late TappableSrpite treeUpgradeSprite;
  late TappableSrpite waterUpgradeSprite;

  List<Component> rewardComponents = [];
  List<Component> upgradeComponents = [];
//Sprite(Flame.images.fromCache('rewards/chest_full_open_anim_f0.png'));
  @override
  Future<void> onLoad() async {
    initComponent();
    rewardComponents = [rewardSpiritSprite, rewardUpgradeSprite];
    upgradeComponents = [
      fireUpgradeSprite,
      treeUpgradeSprite,
      waterUpgradeSprite
    ];
    addAll(rewardComponents);
  }

  @override
  void onGameResize(Vector2 size) {
    rewardSpiritSprite.position = Vector2(size.x * 4 / 10, size.y * 2 / 5);
    rewardUpgradeSprite.position = Vector2(size.x * 6 / 10, size.y * 2 / 5);
    fireUpgradeSprite.position = Vector2(size.x * 4 / 10, size.y * 2 / 5);
    treeUpgradeSprite.position = Vector2(size.x * 5 / 10, size.y * 2 / 5);
    waterUpgradeSprite.position = Vector2(size.x * 6 / 10, size.y * 2 / 5);
    super.onGameResize(size);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  // @override
  // void onTapUp(TapUpEvent event) => gameRef.router.pop();

  void initComponent() {
    rewardSpiritSprite = TappableSrpite(
        tapUpAction: rewardSpirit,
        sprite: Sprite(
            Flame.images.fromCache('rewards/chest_full_open_anim_f0.png')));
    rewardSpiritSprite.anchor = Anchor.center;
    rewardSpiritSprite.size = Vector2(64, 64);

    rewardUpgradeSprite = TappableSrpite(
        tapUpAction: rewardUpgrade,
        sprite: Sprite(Flame.images.fromCache('rewards/item_28.png')));
    rewardUpgradeSprite.anchor = Anchor.center;
    rewardUpgradeSprite.size = Vector2(64, 64);

    fireUpgradeSprite = TappableSrpite(
        tapUpAction: () {
          rewardUpgradeSpirit(SpiritType.fire);
        },
        sprite: Sprite(Flame.images.fromCache('rewards/red_book.png')));
    fireUpgradeSprite.anchor = Anchor.center;
    fireUpgradeSprite.size = Vector2(64, 64);

    treeUpgradeSprite = TappableSrpite(
        tapUpAction: () {
          rewardUpgradeSpirit(SpiritType.tree);
        },
        sprite: Sprite(Flame.images.fromCache('rewards/green_book.png')));
    treeUpgradeSprite.anchor = Anchor.center;
    treeUpgradeSprite.size = Vector2(64, 64);

    waterUpgradeSprite = TappableSrpite(
        tapUpAction: () {
          rewardUpgradeSpirit(SpiritType.water);
        },
        sprite: Sprite(Flame.images.fromCache('rewards/blue_book.png')));
    waterUpgradeSprite.anchor = Anchor.center;
    waterUpgradeSprite.size = Vector2(64, 64);
  }

  void rewardSpirit() {
    Random random = Random();
    var spirits = MasterData().spirits;
    int sumSpiritRewardRatio = MasterData().sumSpiritRewardRatio;
    int spiritRatio = random.nextInt(sumSpiritRewardRatio);
    int currentRatio = 0;
    for (var spirit in spirits) {
      currentRatio += spirit.spiritRewardRatio;
      if (spiritRatio < currentRatio) {
        // gameRef.playerData.spirits.add(spirit.id);
        gameRef.playerState.addSpirit(spirit.id);
        debugPrint(
            '${spirit.spiritRewardRatio / sumSpiritRewardRatio * 100}%확률, ${spirit.name}');
        break;
      }
    }
    endRewardPage();
  }

  void rewardUpgrade() {
    removeAll(rewardComponents);
    addAll(upgradeComponents);
    // endRewardPage();
  }

  void rewardUpgradeSpirit(SpiritType spiritType) {
    gameRef.playerData.spiritUpgrades[spiritType] =
        gameRef.playerData.spiritUpgrades[spiritType]! + 1;
    debugPrint(
        'Upgrade ${spiritType.toString()}type : ${gameRef.playerData.spiritUpgrades[spiritType]}');
    endRewardPage();
  }

  void endRewardPage() {
    gameRef.router.pop();
  }
}
