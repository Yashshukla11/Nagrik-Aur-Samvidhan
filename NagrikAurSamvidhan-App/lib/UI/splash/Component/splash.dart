import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/app_controller.dart';
import '../../../Values/values.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _imageScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start the animation after a short delay to ensure everything is initialized
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _animationController.forward().then((_) {
          // After the animation completes, wait for 1000ms and then navigate
          Future.delayed(const Duration(milliseconds: 1000), () {
            _navigateToNextScreen();
          });
        });
      }
    });
  }

  _navigateToNextScreen() async {
    Get.find<AppController>().checkAuthAndRedirect();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF9933), // Saffron
                  Colors.white, // White
                  Color(0xFF138808), // Green
                ],
                stops: [0.28, 0.5, 0.87], // Distribute colors evenly
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _imageScaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _imageScaleAnimation.value,
                          child: child,
                        );
                      },
                      child: SizedBox(
                        width: Sizes.WIDTH_250,
                        height: Sizes.HEIGHT_250,
                        child: Image.asset(
                          'assets/splash/splashtest.png',
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    AnimatedBuilder(
                      animation: _textOpacityAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textOpacityAnimation.value,
                          child: child,
                        );
                      },
                      child: Text(
                        "Nagrik Aur Samvidhan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                          color: MyColor.white,
                          fontFamily: GoogleFonts.bonheurRoyale().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
