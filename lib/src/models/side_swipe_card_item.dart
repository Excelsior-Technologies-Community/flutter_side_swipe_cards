import 'package:flutter/material.dart';

class SideSwipeCardItem {
  const SideSwipeCardItem({
    required this.child,
    this.id,
  });

  final Widget child;
  final String? id;
}