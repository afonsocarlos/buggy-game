import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_color/game/game.dart';
import 'package:flutter/material.dart';

void main() async {
  BuggyGame game = BuggyGame();

  await performInitialSetup();

  performInitialSetup();

  runApp(
    MaterialApp(
      home: GameWidget(
        game: game,
      ),
    ),
  );
}

Future<void> performInitialSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortraitUpOnly();
}
