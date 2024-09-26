import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/CaseStudiesList/components/widgets/Description.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';

import '../controllers/CaseStudyController.dart';

class CaseStudyComponent extends StatelessWidget {
  final CaseStudyController controller = Get.put(CaseStudyController());

  final List<String> backgroundImages = [
    'https://i.postimg.cc/gkzYkRqF/close-up-old-paper-map.jpg',
    'https://i.postimg.cc/8kyYM6gV/collection-pirate-artifacts-bounty.jpg',
    'https://i.postimg.cc/Pr9FFnq3/mobile-smartphone-magnifier-notebook-with-leather-cover-isolated-black-farm-wooden-table-mysterious.jpg',
    'https://i.postimg.cc/Dy8Mgw74/old-fashioned-flat-lay-with-letters-writing-accessories-dark-wooden-wall.jpg',
    'https://i.postimg.cc/Z5gZcQk4/pexels-cottonbro-8371705.jpg',
    'https://i.postimg.cc/fyggN6fb/pexels-cottonbro-8371715.jpg',
    'https://i.postimg.cc/kgSY0Y6n/truth-concept-composition-detective-desk.jpg',
  ];

  Future<void> _refreshData() async {
    await controller.fetchCaseStudies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Files',
            style: TextStyle(
                fontFamily: 'Sherlock', fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.brown[800],
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            height: Sizes.HEIGHT_10,
            width: Sizes.WIDTH_10,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image(
                image: AssetImage(
                  'assets/arrow.png',
                ),
                color: Colors.white,
                height: Sizes.HEIGHT_10,
                width: Sizes.WIDTH_10,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: Colors.brown[800],
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEAEAEA),
                Color(0xFFDBDBDB),
                Color(0xFFF2F2F2),
                Color(0xFFADA996),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.brown[800]!),
              ));
            } else {
              var caseStudies = controller.caseStudies
                  .where((caseStudy) => caseStudy.type == 'CaseStudy')
                  .toList();

              if (caseStudies.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.library_books,
                          size: 80, color: Colors.brown[800]),
                      SizedBox(height: 20),
                      Text(
                        'No Case Studies available.',
                        style:
                            TextStyle(color: Colors.brown[800], fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: caseStudies.length,
                itemBuilder: (context, index) {
                  var caseStudy = caseStudies[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(backgroundImages[
                                index % backgroundImages.length]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => Description(caseStudy: caseStudy));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  caseStudy.title,
                                  style: const TextStyle(
                                    fontFamily: 'Sherlock',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                AnimatedProgressBar(
                                  percentage:
                                      double.parse(caseStudy.percentage),
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${caseStudy.percentage}% Complete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                // ElevatedButton(
                                //   child: Text(
                                //     double.parse(caseStudy.percentage) > 0
                                //         ? 'Continue'
                                //         : 'Start',
                                //     style: TextStyle(
                                //         fontSize: 18, color: Colors.white),
                                //   ),
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: Colors.brown[800],
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 15),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ),
                                //   onPressed: () {
                                //     Get.to(() =>
                                //         Description(caseStudy: caseStudy));
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}

class AnimatedProgressBar extends StatefulWidget {
  final double percentage;
  final Color color;

  AnimatedProgressBar({required this.percentage, required this.color});

  @override
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage / 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percentage != widget.percentage) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.percentage / 100,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.3),
          ),
          child: FractionallySizedBox(
            widthFactor: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4BC0C8),
                    Color(0xFFC779D0),
                    Color(0xFFFEAC5E),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
