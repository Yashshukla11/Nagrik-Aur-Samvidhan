import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  static const int _contentSize = 4;
  late int _currentIndex;
  late List<ConstitutionPage?> _pages =
      List.filled(_gridSize * _gridSize, null);
  Offset _lastSwipeDir = Offset.zero;
  late ScrollController _horizontalScrollController;
  late ScrollController _verticalScrollController;

  final ConstitutionGalleryController _controller =
      Get.put(ConstitutionGalleryController());

  @override
  void initState() {
    super.initState();
    _currentIndex = (_gridSize * _gridSize) ~/ 2;
    _horizontalScrollController = ScrollController();
    _verticalScrollController = ScrollController();
    _fetchPages();
  }

  Future<void> _fetchPages() async {
    try {
      final fetchedPages =
          await ConstitutionGalleryController.fetchConstitutionPages();
      setState(() {
        List<ConstitutionPage> uniquePages = [];
        List<ConstitutionPage> duplicatePages = [];
        Set<String> seenType1 = {};

        for (var page in fetchedPages) {
          if (page.type == "0") {
            if (!seenType1.contains(page.id)) {
              uniquePages.add(page);
              seenType1.add(page.id);
            }
          } else {
            uniquePages.add(page);
            duplicatePages.add(page);
          }

          if (uniquePages.length >= 16) break;
        }

        while (uniquePages.length < 16 && duplicatePages.isNotEmpty) {
          uniquePages
              .add(duplicatePages[uniquePages.length % duplicatePages.length]);
        }

        int startRow = (_gridSize - _contentSize) ~/ 2;
        int startCol = (_gridSize - _contentSize) ~/ 2;
        for (int i = 0; i < _contentSize; i++) {
          for (int j = 0; j < _contentSize; j++) {
            int index = (startRow + i) * _gridSize + (startCol + j);
            int contentIndex = i * _contentSize + j;
            if (contentIndex < uniquePages.length) {
              _pages[index] = uniquePages[contentIndex];
            }
          }
        }

        _currentIndex = _pages.indexWhere((page) => page?.type == "0");
        if (_currentIndex == -1) _currentIndex = (_gridSize * _gridSize) ~/ 2;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToInitialPosition();
      });
    } catch (e) {
      print('Error fetching pages: $e');
      Get.snackbar('Error', 'Failed to load constitution pages');
    }
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
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );

    _verticalScrollController.animateTo(
      centerY -
          (_verticalScrollController.position.viewportDimension - itemHeight) /
              2,
      duration: Duration(milliseconds: 300),
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
        child: _pages.every((element) => element == null)
            ? Center(child: CircularProgressIndicator())
            : EightWaySwipeDetector(
                onSwipe: _handleSwipe,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemSize = Size(
                      constraints.maxWidth * 3.6 / _gridSize,
                      constraints.maxHeight * 2.71 / _gridSize,
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
            itemCount: _pages.length,
            itemBuilder: (context, index) => _buildImageTile(index, itemSize),
          ),
        ),
      ),
    );
  }

  Widget _buildImageTile(int index, Size itemSize) {
    final isSelected = index == _currentIndex;
    final page = _pages[index];
    if (page == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () => _showImagePopup(page),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isSelected ? 1.1 : .99),
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.pendingStatus,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 1),
          ),
          margin: EdgeInsets.all(16),
          child: Image.network(
            page.image,
            fit: BoxFit.fill,
            width: itemSize.width,
            height: itemSize.height,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.error));
            },
          ),
        ),
      ),
    );
  }

  void _showImagePopup(ConstitutionPage page) async {
    String summary = await _controller.fetchSummary(page.title);

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
                    child: Image.network(
                      page.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  page.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Flexible(
                  child: Container(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        summary,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      left: (_currentIndex % _gridSize) * itemSize.width,
      top: (_currentIndex ~/ _gridSize) * itemSize.height,
      child: Container(
        width: itemSize.width,
        height: itemSize.height,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFFFD700), width: 4),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFD700).withOpacity(0.5),
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

      if (newIndex >= 0 &&
          newIndex < _pages.length &&
          _pages[newIndex] != null) {
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
