import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flappy_color/game/wall.dart';
import 'package:flutter/animation.dart';

import 'constants.dart';

class Player extends PositionComponent with Hitbox, Collidable {
  double speedY = 0.0;

  Paint _colorPaint;

  bool colorAlreadyChanged = false;
  bool exploded = false;
  bool frozen = true;

  Vector2 gameSize;
  Random random;

  Color get color => _colorPaint.color;
  Paint get colorPaint => _colorPaint;
  set color(Color color) => _colorPaint.color = color;

  Player() {
    this.anchor = Anchor.center;
    _colorPaint = Paint()..color = Color(0xffffff00);

    random = Random();

    addShape(HitboxCircle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    print(['Player!', other]);
    debugColor = Color(0xffff00ff);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    this.gameSize = gameSize;
  }

  @override
  Future<void> onLoad() {
    reset();

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    renderShapes(canvas);

    // canvas.drawCircle((size / 2).toOffset(), width, _colorPaint);
  }

  @override
  void update(double t) {
    super.update(t);

    if (frozen) return;

    this.y += speedY * t - GRAVITY * t * t / 2;
    speedY += GRAVITY * t;

    if (y < height || y > gameSize.y - height) reset();
  }

  void jump() {
    speedY = (speedY + BOOST).clamp(BOOST, speedY);
  }

  void reset() {
    speedY = 0;
    frozen = true;
    exploded = false;

    this.x = gameSize.x / 4;
    this.y = gameSize.y / 2;
    this.width = this.height = gameSize.x * .025;
  }

  void start() {
    frozen = false;
  }
}
