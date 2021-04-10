import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';
import 'package:flame/particles.dart';
import 'package:flappy_color/game/brick.dart';
import 'package:flappy_color/game/player.dart';
import 'package:flappy_color/game/wall.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BuggyGame extends BaseGame with HasCollidables, TapDetector {
  Player _player;

  Wall _wall;

  Rect _background;

  bool _gameStarted = false;
  bool _isGameOver = false;
  bool _isGamePaused = false;

  BuggyGame() {
    _player = Player();

    _wall = Wall();
  }

  @override
  Future<void> onLoad() async {
    add(ScreenCollidable());

    add(_player);

    add(_wall);

    _background = size.toRect();
  }

  @override
  void update(double t) {
    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(_background, Paint()..color = Color(0xff202020));

    super.render(canvas);
  }

  @override
  void onResize(Vector2 gameSize) {
    super.onResize(gameSize);
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);

    if (!_gameStarted) {
      start();
    }

    if (!_isGameOver && !_isGamePaused) {
      _player.frozen = false;
      _player.jump();
    }
  }

  @override
  void onTapUp(TapUpDetails details) {
    // print(
    //     "Player tap up on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }

  void start() {
    print('starting');
    _gameStarted = true;
    _player.start();
    _wall.start();
  }
}
