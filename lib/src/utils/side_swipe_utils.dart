import 'dart:math' as math;

class SideSwipeUtils {
  const SideSwipeUtils._();

  static double calculateRotation({
    required double drag,
    required double maxRotation,
    required double swipeThreshold,
  }) {
    if (swipeThreshold <= 0) {
      return 0;
    }

    final progress = (drag.abs() / swipeThreshold).clamp(0.0, 1.0);
    final rotation = progress * maxRotation;

    return drag >= 0 ? rotation : -rotation;
  }

  static double calculateProgress({
    required double drag,
    required double swipeThreshold,
  }) {
    if (swipeThreshold <= 0) {
      return 1;
    }

    return (drag.abs() / swipeThreshold).clamp(0.0, 1.0);
  }

  static double calculateStackScale({
    required int index,
    required double stackScale,
  }) {
    return math.max(0.0, 1.0 - (index * stackScale));
  }

  static bool shouldDismiss({
    required double drag,
    required double swipeThreshold,
  }) {
    return drag.abs() >= swipeThreshold;
  }
}