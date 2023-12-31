import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:spirit_of_the_dungeon/battle/units/enemy.dart';
import 'package:spirit_of_the_dungeon/battle/units/player.dart';
import 'package:spirit_of_the_dungeon/data/player_data.dart';
import 'package:spirit_of_the_dungeon/data/spirit_data.dart';
import 'package:spirit_of_the_dungeon/main/spirit_of_dungeon.dart';
import 'package:spirit_of_the_dungeon/reward/reward_route.dart';
import 'package:spirit_of_the_dungeon/routes/components/background.dart';

typedef BattleUpdate = void Function(double dt);

class BattleRoute extends Component with HasGameRef<SpiritOfDungeon> {
  // late final RoundedButton _button1;
  late final TextComponent _logo;
  late BattleUpdate battleUpdate;
  late Player player;
  late Enemy enemy;
  double attakWaitTime = 0;
  List<SpiritData> spiritDatas = [];
  bool isBattleEnd = false;

  @override
  Future<void> onLoad() async {
    init();
    playerInit();
    enemyInit();
    setSpirit();
    addAll([
      Background(const Color(0xff282828)),
      _logo = TextComponent(
        text: 'BattleRoute',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontWeight: FontWeight.w800,
          ),
        ),
        anchor: Anchor.center,
      ),
      // _button1 = RoundedButton(
      //   text: 'Battle Start',
      //   // action: () => gameRef.router.pushNamed('AdventureRoute'),
      //   action: () => endBattle(),
      //   color: const Color(0xffadde6c),
      //   borderColor: const Color(0xffedffab),
      // ),
      player,
      enemy,
    ]);
  }

  void playerInit() async {
    // final spriteImage = Image.asset('assets/images/Warrior-V1.3/Warrior/SpriteSheet/Warrior_Sheet-Effect.png');
    player = Player();
    player.position = Vector2(gameRef.size.x * 1 / 5, gameRef.size.y * 1 / 2);
  }

  void enemyInit() {
    enemy = Enemy();
    enemy.position = Vector2(gameRef.size.x * 4 / 5, gameRef.size.y * 1 / 2);
    // enemy.scale = Vector2(-1, 1);
    enemy.flipHorizontally();
  }

  void setSpirit() {
    for (int i = 0; i < gameRef.playerData.spirits.length; i++) {
      player.setSpirit(gameRef.playerData.spirits[i].spiritId, enemy);
    }
    for (int i = 0; i < 5; i++) {
      enemy.setSpirit(1, player);
    }
  }

  void init() {
    battleUpdate = playerTurnStart;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 3);
    // _button1.position = Vector2(size.x / 2, _logo.y + 80);
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameMain(dt);
  }

  void gameMain(double dt) {
    if (isBattleEnd) {
      return;
    }
    battleUpdate(dt);
    observeEndCondition();
  }

  void idleUpdate(double dt) {}

  void playerTurnStart(double dt) {
    debugPrint('playerTurnStart');
    player.attackStart();
    attakWaitTime = 1;
    battleUpdate = playerTurn;
  }

  void playerTurn(double dt) {
    if (!player.isAttackTime) {
      if (attakWaitTime > 0) {
        attakWaitTime -= dt;
      } else {
        battleUpdate = enemyTurnStart;
      }
    }
    reflectPlayerData();
  }

  void enemyTurnStart(double dt) {
    debugPrint('enemyTurnStart');
    enemy.attackStart();
    attakWaitTime = 1;
    battleUpdate = enemyTurn;
  }

  void enemyTurn(double dt) {
    if (!enemy.isAttackTime) {
      if (attakWaitTime > 0) {
        attakWaitTime -= dt;
      } else {
        battleUpdate = playerTurnStart;
      }
    }
    reflectPlayerData();
  }

  void endBattle() {
    // removeFromParent();
    gameRef.adventureData.currentMapPoint?.disabled();
    gameRef.adventureData.openNextMapPoint();
    gameRef.router.pop();
  }

  void playerWin() async {
    await gameRef.router.pushAndWait(RewardRoute());
    endBattle();
  }

  void enemyWin() {
    gameOver();
  }

  void observeEndCondition() {
    if (player.isDie) {
      isBattleEnd = true;
      enemyWin();
    } else if (enemy.isDie) {
      isBattleEnd = true;
      playerWin();
    }
  }

  void reflectPlayerData() {
    gameRef.playerData.hp = player.hp;
  }

  void gameOver() {
    game.router.pushNamed('Pause');
  }
}
