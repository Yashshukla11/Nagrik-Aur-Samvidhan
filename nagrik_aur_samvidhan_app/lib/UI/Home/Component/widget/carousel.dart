import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Components/Quiz.dart';
import 'package:nagrik_aur_samvidhan_app/UI/SpinTheWheel/components/SpinTheWheelComponent.dart';

import '../../../Chatbot/Components/chatbot.dart';
import '../../../ConstitutionGallery/Components/ConstitutionGallery.dart';
import '../../Controller/home_controller.dart';

class CarouselWidget extends StatelessWidget {
  final HomeController logic;

  const CarouselWidget({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: logic.pageController,
      itemCount: null,
      reverse: true,
      onPageChanged: (index) {
        logic.updateCurrentPage(index % logic.items.length);
      },
      itemBuilder: (context, index) {
        final adjustedIndex = index % logic.items.length;
        return AnimatedBuilder(
          animation: logic.pageController,
          builder: (context, child) {
            double value = 1.0;
            if (logic.pageController.position.haveDimensions) {
              value = (logic.pageController.page! - index).abs();
              value = 1 - (value * 0.5).clamp(0.0, 1.0);
            }

            return Center(
              child: SizedBox(
                height: Curves.easeOut.transform(value) * 350,
                width: Curves.easeOut.transform(value) * 550,
                child: child,
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              switch (adjustedIndex) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizScreen()));
                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpinTheWheelComponent()));
                  break;
                case 2:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Chatbot()));
                  break;
                case 4:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConstitutionGallery()));
                  break;
                default:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(index: adjustedIndex)));
              }
            },
            child: CarouselItem(logic: logic, index: adjustedIndex),
          ),
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
    final List<String> backgroundImages = [
      'https://i.postimg.cc/qRWcskRT/image1.jpg',
      'https://i.postimg.cc/3xPKQVdw/3d-casino-roulette.jpg',
      'https://i.postimg.cc/Gt2TxTD4/photo-2024-09-12-16-42-55.jpg',
      'https://i.postimg.cc/L56qgwkp/image4.jpg',
      'https://i.postimg.cc/7PmJrPDY/image5.jpg',
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: CachedNetworkImageProvider(backgroundImages[index]),
              fit: BoxFit.cover,
              alignment: Alignment.center),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 35,
                  spreadRadius: 5,
                  offset: Offset(4, 5),
                ),
              ],
            ),
            child: Text(
              logic.items[index],
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Text(
          'Selected item index: $index',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
