import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/CaseStudyController.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaseStudyComponent extends StatelessWidget {
  final CaseStudyController controller = Get.put(CaseStudyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Case Files',
            style: TextStyle(fontFamily: 'Sherlock', fontSize: 24)),
        backgroundColor: Colors.brown[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/CaseStudy/vintage_paper_texture.svg'),
            // Use a placeholder image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/CaseStudy/vintage_paper_texture.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: CircularProgressIndicator(color: Colors.brown[800]));
              } else {
                // Filter case studies to show only those with type 'CaseStudy'
                var caseStudies = controller.caseStudies
                    .where((caseStudy) => caseStudy.type == 'CaseStudy')
                    .toList();

                if (caseStudies.isEmpty) {
                  return Center(
                    child: Text(
                      'No Case Studies available.',
                      style: TextStyle(color: Colors.brown[800], fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: caseStudies.length,
                  itemBuilder: (context, index) {
                    var caseStudy = caseStudies[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.brown[50],
                        child: InkWell(
                          onTap: () {
                            // TODO: Implement case study details navigation
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  caseStudy.title,
                                  style: TextStyle(
                                    fontFamily: 'Sherlock',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[800],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${caseStudy.description.substring(0, 100)}...',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.brown[600],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: caseStudy.isAttempted
                                          ? Colors.brown[800]
                                          : Colors.grey,
                                    ),
                                    if (caseStudy.isAttempted)
                                      Text(
                                        'Solved: ${caseStudy.score}/${caseStudy.totalQuestions}',
                                        style: TextStyle(
                                          color: caseStudy.isPassed
                                              ? Colors.green[800]
                                              : Colors.red[800],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
