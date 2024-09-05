import 'dart:math';
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
    _currentIndex = (_gridSize * _gridSize) ~/ 2; // Center of the grid
    _horizontalScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    // Scroll to the center tile after the layout is complete
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
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );

    _verticalScrollController.animateTo(
      centerY -
          (_verticalScrollController.position.viewportDimension - itemHeight) /
              2,
      duration: Duration(milliseconds: 500),
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
                constraints.maxWidth * 2.8 / _gridSize,
                constraints.maxHeight * 2.7 / _gridSize,
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
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      transform: Matrix4.identity()..scale(isSelected ? 1.0 : .99),
      child: Container(
        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            _imagePaths[index],
            fit: BoxFit.cover,
            width: itemSize.width,
            height: itemSize.height,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedOverlay(Size itemSize) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
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
              offset: Offset(0, 0),
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
