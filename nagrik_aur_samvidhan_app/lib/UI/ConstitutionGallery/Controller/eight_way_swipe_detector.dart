//myapp
import 'package:flutter/widgets.dart';
import 'dart:math';

class EightWaySwipeDetector extends StatefulWidget {
  final Widget child;
  final double threshold;
  final void Function(Offset direction) onSwipe;

  const EightWaySwipeDetector({
    Key? key,
    required this.child,
    this.threshold = 10,
    required this.onSwipe,
  }) : super(key: key);

  @override
  _EightWaySwipeDetectorState createState() => _EightWaySwipeDetectorState();
}

class _EightWaySwipeDetectorState extends State<EightWaySwipeDetector> {
  Offset _startPosition = Offset.zero;
  Offset _endPosition = Offset.zero;
  bool _isSwiping = false;

  void _resetSwipe() {
    _startPosition = _endPosition = Offset.zero;
    _isSwiping = false;
  }

  void _maybeTriggerSwipe() {
    if (!_isSwiping) return;

    Offset moveDelta = _endPosition - _startPosition;
    final distance = moveDelta.distance;

    if (distance >= max(widget.threshold, 1)) {
      moveDelta /= distance;
      Offset dir = Offset(
        moveDelta.dx.roundToDouble(),
        moveDelta.dy.roundToDouble(),
      );
      widget.onSwipe(dir);
      _resetSwipe();
    }
  }

  void _handleSwipeStart(DragStartDetails d) {
    _isSwiping = true;
    _startPosition = _endPosition = d.localPosition;
  }

  void _handleSwipeUpdate(DragUpdateDetails d) {
    _endPosition = d.localPosition;
    _maybeTriggerSwipe();
  }

  void _handleSwipeEnd(DragEndDetails d) {
    _maybeTriggerSwipe();
    _resetSwipe();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: _handleSwipeStart,
      onPanUpdate: _handleSwipeUpdate,
      onPanCancel: _resetSwipe,
      onPanEnd: _handleSwipeEnd,
      child: widget.child,
    );
  }
}
