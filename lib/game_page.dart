import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spirit_of_the_dungeon/main_game.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: MainGame()),
    );
  }
}
