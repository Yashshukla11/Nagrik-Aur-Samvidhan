import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../Values/values.dart';

class HomeController extends GetxController {
  late PageController pageController;
  final currentPage = 0.obs;

  final List<String> items = [
    'Quiz',
    'Spin the wheel',
    'Chatbot',
    'New',
    'About Constitution'
  ];

  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red
  ];

  // Quiz-related properties
  final currentQuestion = ''.obs;
  final currentAnswers = [].obs;
  final correctAnswer = '';
  final quizResult = ''.obs;
  RxString quizSubtitle = MyString.hometext.tr.obs;
  RxString constitutionSubstring = MyString.explor.tr.obs;

  final RxList<NewsItem> newsItems = <NewsItem>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      viewportFraction: 0.8,
      initialPage: items.length *
          1000, // Start from a large number for "infinite" scrolling
    );
    autoScroll();
  }

  void autoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (pageController.hasClients) {
        final nextPage = pageController.page!.toInt() + 1;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      autoScroll();
    });
  }

  void updateCurrentPage(int index) {
    currentPage.value = index % items.length;
  }

  void onDailyQuizTap() {
    print('Navigate to daily quiz');
  }

  void onConstitutionTap() {
    print('Navigate to Constitution');
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      // Simulating API call delay
      await Future.delayed(Duration(seconds: 2));

      newsItems.value = [
        NewsItem(
          title: 'Sample News 1',
          summary: 'This is a summary of the first news item.',
        ),
        NewsItem(
          title: 'Sample News 2',
          summary: 'This is a summary of the second news item.',
        ),
      ];
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class NewsItem {
  final String title;
  final String summary;

  NewsItem({required this.title, required this.summary});
}
