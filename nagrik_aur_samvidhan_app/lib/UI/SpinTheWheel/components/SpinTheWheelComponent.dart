import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../controllers/SpinTheWheelController.dart';

class SpinTheWheelComponent extends StatefulWidget {
  const SpinTheWheelComponent({Key? key}) : super(key: key);

  @override
  _SpinTheWheelComponentState createState() => _SpinTheWheelComponentState();
}

class _SpinTheWheelComponentState extends State<SpinTheWheelComponent> {
  late SpinTheWheelController _controller;
  final List<String> topics = [
    'The Red-Headed League',
    'A Scandal in Bohemia',
    'The Hound of the Baskervilles',
    'The Sign of Four'
  ];

  @override
  void initState() {
    super.initState();
    _controller = SpinTheWheelController(topics);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTopicSelected(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicPage(topic: topics[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        title: const Text('Learn Something New',
            style:
                TextStyle(fontFamily: 'Playfair Display', color: Colors.white)),
        backgroundColor: const Color(0xFF34495E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: FortuneWheel(
                physics: CircularPanPhysics(
                  duration: Duration(seconds: 1),
                  curve: Curves.decelerate,
                ),
                selected: _controller.stream,
                items: [
                  for (var topic in topics)
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          topic,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Playfair Display',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: FortuneItemStyle(
                        color: Color(
                            (topics.indexOf(topic) * 0x40000000 + 0xFFE74C3C) &
                                0xFFFFFFFF),
                        borderWidth: 2,
                        borderColor: Colors.white,
                      ),
                    ),
                ],
                onAnimationEnd: () {
                  _onTopicSelected(_controller.selectedIndex);
                },
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _controller.spin,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFD35400),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Spin the Wheel',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Playfair Display',
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopicPage extends StatelessWidget {
  final String topic;

  const TopicPage({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        title: const Text('Case File',
            style: TextStyle(fontFamily: 'Playfair Display')),
        backgroundColor: const Color(0xFF34495E),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.book, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Let\'s learn about',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Playfair Display'),
            ),
            const SizedBox(height: 10),
            Text(
              topic,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Playfair Display'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
