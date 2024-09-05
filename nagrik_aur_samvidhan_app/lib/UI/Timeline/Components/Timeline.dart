import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/CaseStudiesList/components/CaseStudyComponent.dart';
import 'package:nagrik_aur_samvidhan_app/UI/QuizzesList/components/QuizComponent.dart';
import '../../../Values/values.dart';
import '../Controller/TimelineController.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math' show pi, sin;

class Timeline extends StatelessWidget {
  final TimelineController controller = Get.put(TimelineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: _buildFilteredLevelCards(),
          );
        }
      }),
    );
  }

  List<Widget> _buildFilteredLevelCards() {
    List<String> levels = ['Prarambhik', 'Madhyam', 'Maharathi'];
    RxString type = controller.getType();

    // Filter levels based on the type
    List<String> filteredLevels = levels.where((level) {
      if (type == 'Quiz') {
        return controller.getTotalQuizCount(level) > 0;
      } else if (type == 'CaseStudy') {
        return controller.getTotalCaseStudyCount(level) > 0;
      }
      return false;
    }).toList();

    return levels
        .map((level) => _buildLevelCard(level, _getColorForLevel(level), type))
        .toList();
  }

  Color _getColorForLevel(String level) {
    switch (level) {
      case 'Prarambhik':
        return Colors.orange;
      case 'Madhyam':
        return Colors.white;
      case 'Maharathi':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLevelCard(String level, Color color, RxString type) {
    final isLocked = controller.isLevelLocked(level);

    return GestureDetector(
      onTap: () {
        if (isLocked) {
          _showLockedLevelPopup(level);
        } else {
          if (type == 'Quiz') {
            Get.to(QuizzesComponent(), arguments: {"title": level});
          } else if (type == 'CaseStudy') {
            Get.to(CaseStudyComponent(), arguments: {"title": level});
          }
        }
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(16),
        child: Container(
          height: Sizes.HEIGHT_220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                  'assets/Timeline/${controller.getTitle(level)}.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                color.withOpacity(0.7),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        level,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              level == 'Madhyam' ? Colors.blue : Colors.white,
                        ),
                      ),
                    ),
                    ShakeWidget(
                      child: Icon(
                        isLocked ? Icons.lock : Icons.lock_open,
                        color: level == 'Madhyam' ? Colors.blue : Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 10.0,
                      percent: double.parse(
                              controller.getCompletionPercentage(level)) /
                          100,
                      center: Text(
                        "${controller.getCompletionPercentage(level)}%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color:
                              level == 'Madhyam' ? Colors.blue : Colors.white,
                        ),
                      ),
                      progressColor:
                          level == 'Madhyam' ? Colors.blue : Colors.white,
                      backgroundColor: level == 'Madhyam'
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 1000,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  // width: Sizes.WIDTH_400,
                  child: Center(
                    child: Text(
                      isLocked ? 'Locked' : 'Tap to start',
                      style: TextStyle(
                        fontSize: 16,
                        color: level == 'Madhyam' ? Colors.blue : Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShakeWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double shakeOffset;
  final Curve curve;

  const ShakeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.shakeOffset = 5.0,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            sin(value * pi * 4) * shakeOffset,
            0,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}

void _showLockedLevelPopup(String level) {
  Get.dialog(
    AlertDialog(
      title: Text('Level Locked'),
      content: Text('Please complete the previous levels to unlock $level.'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}
