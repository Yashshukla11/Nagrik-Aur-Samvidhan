import 'dart:ui';
import 'package:get/get.dart';

class ConstitutionGalleryController extends GetxController {
  static const int _gridSize = 3;
  final _index = ((_gridSize * _gridSize) ~/ 2).obs;
  final _lastSwipeDir = Offset.zero.obs;

  int get index => _index.value;

  Offset get lastSwipeDir => _lastSwipeDir.value;

  void setIndex(int value) {
    if (value < 0 || value >= _gridSize * _gridSize) return;
    _index.value = value;
  }

  void handleSwipe(Offset dir) {
    int newIndex = _index.value;
    if (dir.dy != 0) newIndex += _gridSize * (dir.dy > 0 ? -1 : 1);
    if (dir.dx != 0) newIndex += (dir.dx > 0 ? -1 : 1);

    if (newIndex < 0 || newIndex >= _gridSize * _gridSize) return;
    if (dir.dx < 0 && newIndex % _gridSize == 0) return;
    if (dir.dx > 0 && newIndex % _gridSize == _gridSize - 1) return;

    _lastSwipeDir.value = dir;
    setIndex(newIndex);
  }
}
