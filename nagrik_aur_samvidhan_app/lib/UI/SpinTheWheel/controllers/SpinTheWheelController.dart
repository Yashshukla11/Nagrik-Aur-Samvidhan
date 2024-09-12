import 'dart:math';
import 'dart:async';

class SpinTheWheelController {
  final List<String> topics;
  late String selectedTopic;
  int selectedIndex = 0;
  final _streamController = StreamController<int>.broadcast();
  final _random = Random();

  Stream<int> get stream => _streamController.stream;

  SpinTheWheelController(this.topics) {
    selectedTopic = topics.first;
  }

  void spin() {
    int newIndex;
    do {
      newIndex = _random.nextInt(topics.length);
    } while (newIndex == selectedIndex && topics.length > 1);

    selectedIndex = newIndex;
    selectedTopic = topics[selectedIndex];
    _streamController.add(selectedIndex);
  }

  void dispose() {
    _streamController.close();
  }
}
