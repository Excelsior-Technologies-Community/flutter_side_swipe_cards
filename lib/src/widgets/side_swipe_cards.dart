import 'package:flutter/material.dart';

import '../models/side_swipe_card_config.dart';
import '../models/side_swipe_card_item.dart';
import '../utils/side_swipe_utils.dart';

class SideSwipeCards extends StatefulWidget {
  const SideSwipeCards({
    super.key,
    required this.cards,
    this.config = const SideSwipeCardConfig(),
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onCardTap,
    this.onEmpty,
  });

  final List<SideSwipeCardItem> cards;
  final SideSwipeCardConfig config;
  final ValueChanged<SideSwipeCardItem>? onSwipeLeft;
  final ValueChanged<SideSwipeCardItem>? onSwipeRight;
  final ValueChanged<SideSwipeCardItem>? onCardTap;
  final VoidCallback? onEmpty;

  @override
  State<SideSwipeCards> createState() => _SideSwipeCardsState();
}

class _SideSwipeCardsState extends State<SideSwipeCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double _dragX = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.config.animationDuration,
    );

    _animationController.addListener(() {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  SideSwipeCardItem? get _currentCard {
    if (widget.cards.isEmpty) {
      return null;
    }

    return widget.cards.first;
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.config.enableSwipe || _isAnimating) {
      return;
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.config.enableSwipe || _isAnimating) {
      return;
    }

    final nextDrag = _dragX + details.delta.dx;

    if (!widget.config.enableLeftSwipe && nextDrag < 0) {
      return;
    }

    if (!widget.config.enableRightSwipe && nextDrag > 0) {
      return;
    }

    setState(() {
      _dragX = nextDrag;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.config.enableSwipe || _isAnimating) {
      return;
    }

    if (SideSwipeUtils.shouldDismiss(
      drag: _dragX,
      swipeThreshold: widget.config.swipeThreshold,
    )) {
      _dismissCard();
    } else {
      _resetCard();
    }
  }

  void _dismissCard() {
    final card = _currentCard;

    if (card == null) {
      widget.onEmpty?.call();
      return;
    }

    final direction = _dragX >= 0 ? 1.0 : -1.0;

    if (direction < 0 && !widget.config.enableLeftSwipe) {
      _resetCard();
      return;
    }

    if (direction > 0 && !widget.config.enableRightSwipe) {
      _resetCard();
      return;
    }

    _isAnimating = true;

    final startDrag = _dragX;
    final targetDrag =
        direction * MediaQuery.sizeOf(context).width * 1.5;

    final animation = Tween<double>(
      begin: startDrag,
      end: targetDrag,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.duration = widget.config.dismissDuration;
    _animationController.forward(from: 0).then((_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _dragX = 0;
        _isAnimating = false;
      });

      if (widget.cards.isNotEmpty) {
        widget.cards.removeAt(0);
      }

      if (direction < 0) {
        widget.onSwipeLeft?.call(card);
      } else {
        widget.onSwipeRight?.call(card);
      }

      if (widget.cards.isEmpty) {
        widget.onEmpty?.call();
      }
    });

    void updateDrag() {
      if (!mounted) {
        return;
      }

      setState(() {
        _dragX = animation.value;
      });
    }

    _animationController.addListener(updateDrag);

    _animationController.addStatusListener(
          (status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          _animationController.removeListener(updateDrag);
        }
      },
    );
  }

  void _resetCard() {
    _isAnimating = true;

    final animation = Tween<double>(
      begin: _dragX,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.duration = widget.config.animationDuration;

    void updateDrag() {
      if (!mounted) {
        return;
      }

      setState(() {
        _dragX = animation.value;
      });
    }

    _animationController.addListener(updateDrag);

    _animationController.forward(from: 0).then((_) {
      if (!mounted) {
        return;
      }

      _animationController.removeListener(updateDrag);

      setState(() {
        _dragX = 0;
        _isAnimating = false;
      });
    });
  }

  void _handleTap() {
    if (!widget.config.enableTap || _isAnimating) {
      return;
    }

    final card = _currentCard;

    if (card != null) {
      widget.onCardTap?.call(card);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleCount = widget.config.visibleCards.clamp(
      1,
      widget.cards.length,
    );

    return Stack(
      alignment: Alignment.center,
      children: List.generate(
        visibleCount,
            (index) {
          final reverseIndex = visibleCount - index - 1;
          final card = widget.cards[reverseIndex];

          if (reverseIndex == 0) {
            return _buildFrontCard(card);
          }

          return _buildBackgroundCard(
            card: card,
            index: reverseIndex,
          );
        },
      ),
    );
  }

  Widget _buildFrontCard(SideSwipeCardItem card) {
    final rotation = SideSwipeUtils.calculateRotation(
      drag: _dragX,
      maxRotation: widget.config.maxRotation,
      swipeThreshold: widget.config.swipeThreshold,
    );

    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      onTap: _handleTap,
      child: Transform.translate(
        offset: Offset(_dragX, 0),
        child: Transform.rotate(
          angle: rotation,
          child: _buildCardContainer(card.child),
        ),
      ),
    );
  }

  Widget _buildBackgroundCard({
    required SideSwipeCardItem card,
    required int index,
  }) {
    final scale = SideSwipeUtils.calculateStackScale(
      index: index,
      stackScale: widget.config.stackScale,
    );

    return Transform.translate(
      offset: Offset(
        0,
        index * widget.config.stackOffset,
      ),
      child: Transform.scale(
        scale: scale,
        child: IgnorePointer(
          child: _buildCardContainer(card.child),
        ),
      ),
    );
  }

  Widget _buildCardContainer(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        widget.config.cardBorderRadius,
      ),
      child: child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}