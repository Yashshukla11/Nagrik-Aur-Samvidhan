import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../../../../Values/values.dart';
import '../../../PlayQuiz/components/PlayQuiz.dart';
import '../../controllers/CaseStudyController.dart';

class Description extends StatelessWidget {
  final CaseStudy caseStudy;

  Description({required this.caseStudy});

  String _preprocessMarkdown(String text) {
    text = text.replaceAll('<br>', '  \n');
    text = text.replaceAll(RegExp(r'(\n\s*-)', multiLine: true), '\n\n-');
    text = text.replaceAll(RegExp(r'(\n\s*#+)', multiLine: true), '\n\n#');
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                color: Colors.brown,
                height: Sizes.HEIGHT_10,
                width: Sizes.WIDTH_10,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying title at the top
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: Sizes.WIDTH_300,
                    child: Text(
                      caseStudy.title,
                      style: const TextStyle(
                        fontFamily: 'Sherlock',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Markdown content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MarkdownBody(
                data: _preprocessMarkdown(caseStudy.description),
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(
                    fontSize: 16,
                    color: Colors.brown[800],
                    height: 1.5,
                  ),
                  strong: TextStyle(
                    fontSize: 16,
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                  ),
                  h1: TextStyle(
                    fontSize: 24,
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                    height: 1.7,
                  ),
                  h2: TextStyle(
                    fontSize: 22,
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                    height: 1.7,
                  ),
                  h3: TextStyle(
                    fontSize: 20,
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                    height: 1.7,
                  ),
                  listBullet: TextStyle(fontSize: 16, color: Colors.brown[800]),
                  listIndent: 20.0,
                  blockSpacing: 16.0,
                  horizontalRuleDecoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.brown[300]!),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // New text based on case study
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Let's figure out some questions based on this case study!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Start/Continue button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    double.parse(caseStudy.percentage) > 0
                        ? 'Continue'
                        : 'Start',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => PlayQuiz(), arguments: {
                      'quizId': caseStudy.id,
                      'type': 'CaseStudy',
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
