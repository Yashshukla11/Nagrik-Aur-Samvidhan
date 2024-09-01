import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Values/values.dart';
import 'spaces.dart';

class ToastContext {
  BuildContext? context;
  MethodChannel? _channel;

  static final ToastContext _instance = ToastContext._internal();

  /// Prmary Constructor for FToast
  factory ToastContext() => _instance;

  /// Take users Context and saves to avariable
  ToastContext init(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  ToastContext._internal();
}

class Toast {
  static const int lengthShort = 2;
  static const int lengthLong = 3;
  static const int bottom = 0;
  static const int center = 1;
  static const int top = 2;

  static void show(String msg,
      {int? duration = 1,
      int? gravity = 0,
      Color backgroundColor = const Color(0xAA000000),
      textStyle = const TextStyle(fontSize: 15, color: Colors.white),
      double backgroundRadius = 20,
      bool? rootNavigator,
      Border? border,
      bool webShowClose = false,
      Color webTexColor = const Color(0xFFffffff),
      bool? showImage,
      TextAlign? textAlign}) {
    if (ToastContext().context == null) {
      throw Exception(
          'Context is null, please call ToastContext.init(context) first');
    }
    if (kIsWeb == true) {
      if (ToastContext()._channel == null) {
        ToastContext()._channel = const MethodChannel('appdev/FlutterToast');
      }
      String toastGravity = 'bottom';
      if (gravity == Toast.top) {
        toastGravity = 'top';
      } else if (gravity == Toast.center) {
        toastGravity = 'center';
      } else {
        toastGravity = 'bottom';
      }

      final Map<String, dynamic> params = <String, dynamic>{
        'msg': msg,
        'duration': (duration ?? 1) * 1000,
        'gravity': toastGravity,
        'bgcolor': backgroundColor.toString(),
        'textcolor': webTexColor.value.toRadixString(16),
        'webShowClose': webShowClose,
      };
      ToastContext()._channel?.invokeMethod('showToast', params);
    } else {
      ToastView.dismiss();
      ToastView.createView(
          msg,
          ToastContext().context!,
          duration,
          gravity,
          backgroundColor,
          textStyle,
          backgroundRadius,
          border,
          rootNavigator,
          showImage,
          textAlign);
    }
  }
}

class ToastView {
  static final ToastView _singleton = ToastView._internal();

  factory ToastView() => _singleton;

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static Future<void> createView(
    String msg,
    BuildContext context,
    int? duration,
    int? gravity,
    Color background,
    TextStyle textStyle,
    double backgroundRadius,
    Border? border,
    bool? rootNavigator,
    bool? showImage,
    TextAlign? textAlign,
  ) async {
    overlayState = Overlay.of(context, rootOverlay: rootNavigator ?? false);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(backgroundRadius),
                    border: border,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (showImage ?? false)
                        Wrap(
                          children: [
                            // Image.asset(
                            //   ImagePath.appLogo,
                            //   height: 25.w,
                            //   width: 25.w,
                            // ),
                            const SpaceW12(),
                          ],
                        )
                      else
                        const SizedBox.shrink(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.WIDTH_4),
                        child: Text(msg,
                            softWrap: true,
                            textAlign: textAlign,
                            style: textStyle),
                      ),
                    ],
                  ),
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(Duration(seconds: duration ?? Toast.lengthShort));
    dismiss();
  }

  static Future<void> dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    super.key,
    required this.widget,
    required this.gravity,
  });

  final Widget widget;
  final int? gravity;

  @override
  Widget build(BuildContext context) => Positioned(
      top: gravity == 2 ? MediaQuery.of(context).viewInsets.top + 50 : null,
      bottom:
          gravity == 0 ? MediaQuery.of(context).viewInsets.bottom + 50 : null,
      child: IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: widget,
        ),
      ));
}
