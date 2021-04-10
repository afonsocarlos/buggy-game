import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flappy_color/game/brick.dart';
import 'package:flappy_color/game/game.dart';

List<Paint> colors = [
  Paint()..color = Color(0xffffff00), // yellow
  Paint()..color = Color(0xffff00ff), // magenta
  Paint()..color = Color(0xff8000ff), // purple
  Paint()..color = Color(0xff00ffff), // cyan
];

class Wall extends BaseComponent with HasGameRef<BuggyGame> {
  static int totalBricks = 4;
  static double speedX = 100.0;

  Timer _timer;
  double _time = 3;

  Wall() {
    _timer = Timer(_time, repeat: true, callback: () {
      createWall();
    });
  }

  void createWall() {
    Wall.speedX *= 1.05;

    colors.shuffle();
    colors.asMap().forEach((index, color) {
      gameRef.add(Brick(index, color));
    });
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }

  void start() {
    _timer.start();
  }

  @override
  void update(double t) {
    super.update(t);

    _timer.update(t);
  }
}
