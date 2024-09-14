import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      _showURLErrorDialog(context, url);
    }
  }

  void _showURLErrorDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unable to Open Link'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'We couldn\'t open the link in your browser. What would you like to do?'),
                SizedBox(height: 20),
                Text(
                  url,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Copy Link'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: url));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Link copied to clipboard')),
                );
              },
            ),
            TextButton(
              child: Text('Open in WebView'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebViewPage(url: url),
                ));
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            // Display the image
            if (caseStudy.image != null && caseStudy.image!.isNotEmpty)
              Image.network(
                caseStudy.image!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            // Displaying title
            Padding(
              padding: const EdgeInsets.all(16),
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
            // Source URL
            if (caseStudy.url != null && caseStudy.url!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.link),
                  label: Text('View Source Article'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown[700],
                  ),
                  onPressed: () => _launchURL(context, caseStudy.url!),
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

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source Article'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
