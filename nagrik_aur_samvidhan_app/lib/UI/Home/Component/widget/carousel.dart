import 'package:flutter/material.dart';
import '../../Controller/home_controller.dart';

class CarouselWidget extends StatelessWidget {
  final HomeController logic;

  const CarouselWidget({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: logic.pageController,
      itemCount: null,
      // Set to null for infinite scrolling
      reverse: true,
      // This makes the carousel move from right to left
      onPageChanged: (index) {
        logic.updateCurrentPage(index);
      },
      itemBuilder: (context, index) {
        final adjustedIndex = index % logic.items.length;
        return AnimatedBuilder(
          animation: logic.pageController,
          builder: (context, child) {
            double value = 1.0;
            if (logic.pageController.position.haveDimensions) {
              value = (logic.pageController.page! - index).abs();
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                height: Curves.easeOut.transform(value) * 300,
                width: Curves.easeOut.transform(value) * 300,
                child: child,
              ),
            );
          },
          child: CarouselItem(logic: logic, index: adjustedIndex),
        );
      },
    );
  }
}

class CarouselItem extends StatelessWidget {
  final HomeController logic;
  final int index;

  const CarouselItem({Key? key, required this.logic, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: logic.colors[index],
        ),
        child: Center(
          child: Text(
            logic.items[index],
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
