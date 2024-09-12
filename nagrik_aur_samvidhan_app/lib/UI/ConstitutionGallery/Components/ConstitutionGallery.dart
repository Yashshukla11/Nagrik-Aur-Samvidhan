import 'package:flutter/material.dart';

import '../../../Values/values.dart';
import '../Controller/ConstitutionGalleryController.dart';
import '../Controller/eight_way_swipe_detector.dart';

class ConstitutionGallery extends StatefulWidget {
  const ConstitutionGallery({Key? key}) : super(key: key);

  @override
  _ConstitutionGalleryState createState() => _ConstitutionGalleryState();
}

class _ConstitutionGalleryState extends State<ConstitutionGallery> {
  static const int _gridSize = 6;
  late int _currentIndex;
  late final List<String> _imagePaths =
      ConstitutionGalleryController.getConstitutionPages();
  Offset _lastSwipeDir = Offset.zero;
  late ScrollController _horizontalScrollController;
  late ScrollController _verticalScrollController;

  @override
  void initState() {
    super.initState();
    _currentIndex = (_gridSize * _gridSize) ~/ 2;
    _horizontalScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialPosition();
    });
  }

  void _scrollToInitialPosition() {
    final itemWidth =
        _horizontalScrollController.position.viewportDimension / _gridSize;
    final itemHeight =
        _verticalScrollController.position.viewportDimension / _gridSize;

    final centerX = (_currentIndex % _gridSize) * itemWidth;
    final centerY = (_currentIndex ~/ _gridSize) * itemHeight;

    _horizontalScrollController.animateTo(
      centerX -
          (_horizontalScrollController.position.viewportDimension - itemWidth) /
              2,
      duration: Duration(milliseconds: 10),
      curve: Curves.easeOutCubic,
    );

    _verticalScrollController.animateTo(
      centerY -
          (_verticalScrollController.position.viewportDimension - itemHeight) /
              2,
      duration: Duration(milliseconds: 10),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: EightWaySwipeDetector(
          onSwipe: _handleSwipe,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemSize = Size(
                constraints.maxWidth * 2.74 / _gridSize,
                constraints.maxHeight * 2.41 / _gridSize,
              );
              return Stack(
                children: [
                  _buildImageGrid(itemSize),
                  _buildAnimatedOverlay(itemSize),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid(Size itemSize) {
    return SingleChildScrollView(
      controller: _verticalScrollController,
      child: SingleChildScrollView(
        controller: _horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: itemSize.width * _gridSize,
          height: itemSize.height * _gridSize,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridSize,
              childAspectRatio: itemSize.aspectRatio,
            ),
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) => _buildImageTile(index, itemSize),
          ),
        ),
      ),
    );
  }

  Widget _buildImageTile(int index, Size itemSize) {
    final isSelected = index == _currentIndex;
    return GestureDetector(
      onTap: () => _showImagePopup(index),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: Duration(milliseconds: 10),
        transform: Matrix4.identity()..scale(isSelected ? 1.0 : .99),
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.pendingStatus,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 1),
          ),
          margin: EdgeInsets.all(8),
          child: Image.asset(
            _imagePaths[index],
            fit: BoxFit.fill,
            width: itemSize.width,
            height: itemSize.height,
          ),
        ),
      ),
    );
  }

  void _showImagePopup(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: InteractiveViewer(
                    boundaryMargin: EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.asset(
                      _imagePaths[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Constitution Page ${index + 1}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "This is page ${index + 1} of the constitution. It contains important information about the fundamental principles and laws of the nation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedOverlay(Size itemSize) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 10),
      curve: Curves.easeOutCubic,
      left: (_currentIndex % _gridSize) * itemSize.width,
      top: (_currentIndex ~/ _gridSize) * itemSize.height,
      child: Container(
        width: itemSize.width,
        height: itemSize.height,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFFFD700), width: 4),
          // Golden color
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFD700).withOpacity(0.5),
              // Golden color with opacity
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(5, 7),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSwipe(Offset direction) {
    setState(() {
      _lastSwipeDir = direction;
      int newIndex = _currentIndex;

      if (direction.dy != 0) {
        newIndex += _gridSize * (direction.dy > 0 ? 1 : -1);
      }
      if (direction.dx != 0) {
        newIndex += (direction.dx > 0 ? 1 : -1);
      }

      if (newIndex >= 0 && newIndex < _imagePaths.length) {
        _currentIndex = newIndex;
        _scrollToIndex(newIndex, direction);
      }
    });
  }

  void _scrollToIndex(int index, Offset direction) {
    final itemWidth = _horizontalScrollController.position.viewportDimension *
        0.8 /
        _gridSize;
    final itemHeight =
        _verticalScrollController.position.viewportDimension * 0.8 / _gridSize;
    final row = index ~/ _gridSize;
    final column = index % _gridSize;

    if (direction.dx != 0) {
      final targetScrollX = (column * itemWidth) -
          (_horizontalScrollController.position.viewportDimension - itemWidth) /
              2;
      _horizontalScrollController.animateTo(
        targetScrollX.clamp(
            0, _horizontalScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }

    if (direction.dy != 0) {
      final targetScrollY = (row * itemHeight) -
          (_verticalScrollController.position.viewportDimension - itemHeight) /
              2;
      _verticalScrollController.animateTo(
        targetScrollY.clamp(
            0, _verticalScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }
}
