import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Elements/Widgets/spaces.dart';
import '../../../Values/values.dart';
import '../Controller/TimelineController.dart';

class Timeline extends StatelessWidget {
  final TimelineController controller = Get.put(TimelineController());

  @override
  Widget build(BuildContext context) {
    final String timelineTitle = MyString.Timeline.tr;
    final String heading1 = MyString.heading1.tr;
    final String heading2 = MyString.heading2.tr;
    final String heading3 = MyString.heading3.tr;
    final String heading4 = MyString.heading4.tr;
    final String heading5 = MyString.heading5.tr;

    final Map<String, String> subheadings = {
      heading1: MyString.sub1.tr,
      heading2: MyString.sub2.tr,
      heading3: MyString.sub3.tr,
      heading4: MyString.sub4.tr,
      heading5: MyString.sub5.tr,
    };

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/ChatBot/arrow.png'),
          ),
        ),
        title: Text(
          timelineTitle,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.levels.length,
          itemBuilder: (context, index) {
            var level = controller.levels[index];

            // Assign a background color based on the index
            Color backgroundColor;
            switch (index % 5) {
              case 0:
                backgroundColor = Colors.blueAccent;
                break;
              case 1:
                backgroundColor = Colors.greenAccent;
                break;
              case 2:
                backgroundColor = Colors.orangeAccent;
                break;
              case 3:
                backgroundColor = Colors.purpleAccent;
                break;
              case 4:
                backgroundColor = Colors.redAccent;
                break;
              default:
                backgroundColor = Colors.grey;
                break;
            }

            // Retrieve the subheading from the map
            String subheading = subheadings[level['name']] ?? "";

            return Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level['name']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subheading,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      controller.isLevelUnlocked(index)
                          ? Icons.lock_open
                          : Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
