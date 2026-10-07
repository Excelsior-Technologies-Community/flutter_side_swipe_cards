import 'package:flutter/material.dart';

@immutable
class SideSwipeCardConfig {
  const SideSwipeCardConfig({
    this.visibleCards = 3,
    this.swipeThreshold = 120,
    this.maxRotation = 0.08,
    this.stackOffset = 14,
    this.stackScale = 0.04,
    this.animationDuration = const Duration(milliseconds: 350),
    this.dismissDuration = const Duration(milliseconds: 300),
    this.enableSwipe = true,
    this.enableLeftSwipe = true,
    this.enableRightSwipe = true,
    this.enableTap = true,
    this.cardBorderRadius = 20,
  })  : assert(visibleCards > 0),
        assert(swipeThreshold > 0),
        assert(maxRotation >= 0),
        assert(stackOffset >= 0),
        assert(stackScale >= 0),
        assert(cardBorderRadius >= 0);

  final int visibleCards;
  final double swipeThreshold;
  final double maxRotation;
  final double stackOffset;
  final double stackScale;
  final Duration animationDuration;
  final Duration dismissDuration;
  final bool enableSwipe;
  final bool enableLeftSwipe;
  final bool enableRightSwipe;
  final bool enableTap;
  final double cardBorderRadius;
}