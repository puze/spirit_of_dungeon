import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spirit_of_the_dungeon/main/game_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(const MaterialApp(
    home: GamePage(),
  ));
}
