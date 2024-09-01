import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/home_controller.dart';

class NewsSection extends StatelessWidget {
  final HomeController logic;

  const NewsSection({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest News',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Obx(() => logic.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : logic.newsItems.isEmpty
                  ? Center(child: Text('No news available'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: logic.newsItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(logic.newsItems[index].title),
                          subtitle: Text(logic.newsItems[index].summary),
                        );
                      },
                    )),
        ],
      ),
    );
  }
}
