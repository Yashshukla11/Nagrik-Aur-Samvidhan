import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/ConstitutionGalleryController.dart';
import '../ImageDb/ImageData.dart';

class ConstitutionGallery extends StatelessWidget {
  const ConstitutionGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConstitutionGalleryController());
    return _GalleryContent();
  }
}

class _GalleryContent extends GetView<ConstitutionGalleryController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageSize = Size(size.width * 0.8, size.height * 0.8);

    return GestureDetector(
      onPanUpdate: (details) {
        controller.handleSwipe(Offset(
          details.delta.dx > 0 ? 1 : -1,
          details.delta.dy > 0 ? 1 : -1,
        ));
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Obx(() => _buildImage(
              context, index, controller.index == index, imageSize));
        },
      ),
    );
  }

  Widget _buildImage(
      BuildContext context, int index, bool isSelected, Size imageSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..scale(isSelected ? 1.15 : 1.0),
      child: GestureDetector(
        onTap: () => controller.setIndex(index),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            ImageData.images[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
