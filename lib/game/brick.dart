import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flappy_color/game/player.dart';
import 'package:flappy_color/game/wall.dart';
import 'package:flutter/animation.dart';

class Brick extends PositionComponent with Hitbox, Collidable {
  int _index;
  Paint _color;
  bool hit = false;

  Vector2 gameSize;

  Color get color => _color.color;

  Brick(int index, Paint color) {
    _index = index;
    _color = color;
    this.anchor = Anchor.topCenter;

    addShape(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Player) {
      print(['Brick!', other]);
      debugColor = Color(0xffff00ff);
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    this.gameSize = gameSize;
  }

  @override
  Future<void> onLoad() {
    this.width = gameSize.x * 0.03;
    this.height = gameSize.y / Wall.totalBricks;

    this.x = gameSize.x + this.width;
    this.y = gameSize.y * _index / Wall.totalBricks;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    renderShapes(canvas);

    // canvas.drawRect(size.toRect(), _color);
  }

  @override
  void update(double t) {
    super.update(t);

    this.x -= Wall.speedX * t;

    if (x < -width) {
      remove();
    }
  }
}
