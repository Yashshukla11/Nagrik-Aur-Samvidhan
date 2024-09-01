part of 'values.dart';

class Decorations {
  Decorations._();

  static BoxDecoration customBoxDecoration({
    double blurRadius = 5,
    Color color = const Color(0xFFD6D7FB),
  }) =>
      BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: blurRadius, color: color)]);

  static OutlineInputBorder textFieldBorder({Color? color, double? radius}) =>
      OutlineInputBorder(
          borderSide: BorderSide(color: color ?? MyColor.white, width: 1.5),
          borderRadius: BorderRadius.circular(radius ?? Sizes.RADIUS_30));

  static BorderRadiusGeometry roundedRadius(
          {BorderRadiusGeometry? borderRadius,
          double? radius,
          double? borderWidth,
          DecorationImage? image}) =>
      borderRadius ??
      BorderRadius.all(Radius.circular(radius ?? Sizes.RADIUS_20));

  static BoxDecoration onBoardingButtonDecoration(
          {Color? color, double? radius}) =>
      BoxDecoration(shape: BoxShape.circle, color: color ?? MyColor.appTheme);

  static BoxDecoration exitDialogBoxDecoration({
    double blurRadius = 5,
    Color color = const Color(0xFFD6D7FB),
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
  }) =>
      BoxDecoration(color: color, shape: shape, borderRadius: borderRadius);

  static BoxDecoration textFieldBoxShadow({
    Color? color,
    Color? borderColor,
    double? width,
    double? dyOffset,
    double? dxOffset,
    Radius? topRight,
  }) =>
      BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: MyColor.blackShade9.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
              blurStyle: BlurStyle.outer,
              offset: Offset(dxOffset ?? 0, dyOffset ?? -1),
            )
          ],
          borderRadius: BorderRadius.circular(Sizes.RADIUS_8));

  static BoxDecoration textFieldDecoration() => BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_8)),
      border: Border.all(color: MyColor.appTheme, width: 1));

  static InputDecoration textFieldOutDecoration({
    String? hint,
    Color? fillColor,
    Color? hintColor,
    Color? borderColor,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        fillColor: fillColor ?? MyColor.appTheme14,
        filled: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                horizontal: Sizes.WIDTH_20, vertical: Sizes.HEIGHT_14),
        border: Decorations.searchDecoration(
            radius: Sizes.RADIUS_14, borderColor: borderColor ?? MyColor.grey),
        focusedBorder: Decorations.searchDecoration(
            radius: Sizes.RADIUS_14, borderColor: borderColor ?? MyColor.appTheme),
        enabledBorder: Decorations.searchDecoration(
            radius: Sizes.RADIUS_14, borderColor: borderColor ?? MyColor.grey),
        hintText: hint,
        hintStyle: TextStyles.hintTextStyle.copyWith(
            fontSize: Sizes.TEXT_SIZE_28,
            color: hintColor ?? MyColor.whiteShade1),
        // suffixIcon: isFieldFocus.value
        //     ? IconButton(
        //   icon: Icon(
        //     Icons.clear,
        //     color: isContrast
        //         ? MyColor.white
        //         : MyColor.black,
        //     size: Sizes.WIDTH_34,
        //   ),
        //   onPressed: () {
        //     Get.focusScope?.unfocus();
        //     searchTextController?.clear();
        //   },
        // )
        //
        // // Add a search icon or button to the search bar
        // prefixIcon: IconButton(
        //   padding: EdgeInsets.only(bottom: Sizes.WIDTH_2),
        //   icon: Image.asset(
        //     IconPath.searchIcon,
        //     color: isContrast
        //         ? isFieldFocus.value
        //         ? MyColor.white
        //         : MyColor.whiteShade1
        //         : isFieldFocus.value
        //         ? MyColor.black
        //         : MyColor.gray,
        //     width: Sizes.WIDTH_32,
        //     height: Sizes.WIDTH_32,
        //   ),
        //   onPressed: () {
        //     // Perform the search here
        //   },
        // ),
      );

  static InputDecoration fieldOutDecoration({
    String? hint,
    Color? fillColor,
    Color? hintColor,
    Color? borderColor,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        fillColor: fillColor ?? MyColor.appTheme14,
        filled: true,
        contentPadding: contentPadding,
        border: Borders.noBorder,
        focusedBorder: Borders.noBorder,
        enabledBorder: Borders.noBorder,
        errorBorder: Borders.noBorder,
        focusedErrorBorder: Borders.noBorder,
        disabledBorder: Borders.noBorder,
        hintText: hint,
        hintStyle: TextStyles.hintTextStyle.copyWith(
            fontSize: Sizes.TEXT_SIZE_28,
            color: hintColor ?? MyColor.whiteShade1),
      );

  static BoxDecoration loginBoxDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth,
          List<BoxShadow>? boxShadow}) =>
      BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          borderRadius:
              borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 0)),
          border: Border.all(
              color: borderColor ?? MyColor.black, width: borderWidth ?? 2),
          boxShadow: boxShadow ?? []);

  static List<BoxShadow> personDetailBoxShadow(
          {Color? color,
          double? blurRadius,
          BlurStyle? blurStyle,
          Offset? offset,
          double? spreadRadius}) =>
      [
        BoxShadow(
          color: color ?? MyColor.boxShadow,
          blurRadius: blurRadius ?? 50,
          blurStyle: blurStyle ?? BlurStyle.normal,
          offset: offset ?? const Offset(0, 20),
          spreadRadius: spreadRadius ?? 0,
        )
      ];

  static BoxDecoration borderDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          borderRadius:
              borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 0)),
          border: Border.all(
              color: borderColor ?? MyColor.textHintColor,
              width: borderWidth ?? 1.5));

  static BoxDecoration shapeDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          // borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 0)),
          border: Border.all(
              color: borderColor ?? MyColor.textHintColor,
              width: borderWidth ?? 1.5));

  static BoxDecoration roundedBoxDecoration(
          {double? borderRadius,
          Color? bdColor,
          Color? borderColor,
          Color? bgColor,
          double? borderWidth,
          List<BoxShadow>? boxShadow}) =>
      BoxDecoration(
          color: bgColor ?? MyColor.white,
          border: Border.all(
              color: borderColor ?? MyColor.transparent,
              width: borderWidth ?? 0),
          borderRadius: BorderRadius.circular(borderRadius ?? Sizes.RADIUS_40),
          boxShadow: boxShadow);

  static BoxDecoration roundedGradiantBoxDecoration(
          {double? borderRadius,
          Color? bdColor,
          Color? borderColor,
          Color? bgColor,
          double? borderWidth,
          Gradient? gradient,
          List<Color>? colors,
          List<BoxShadow>? boxShadow}) =>
      BoxDecoration(
        color: bgColor ?? MyColor.white,
        border: Border.all(
            color: borderColor ?? MyColor.transparent, width: borderWidth ?? 0),
        borderRadius: BorderRadius.circular(borderRadius ?? Sizes.RADIUS_40),
        boxShadow: boxShadow,
        gradient: gradient ?? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors ?? [const Color(0xFFEAEFFF), const Color(0xFFFAF9FF)],
            ),
      );

  static List<BoxShadow>? bgBoxShadow(
          {double? blurRadius, Offset? offset, Color? color}) =>
      [
        BoxShadow(
          color: color ?? MyColor.shadowColor,
          blurRadius: blurRadius ?? 7,
          offset: offset ?? const Offset(0, 2),
        )
      ];

  static List<BoxShadow>? homeBoxShadow(
          {double? blurRadius, Offset? offset, Color? color}) =>
      [
        BoxShadow(
          color: color ?? MyColor.shadowColor,
          blurRadius: blurRadius ?? 4,
          offset: offset ?? const Offset(0, 1.5),
        )
      ];

  static List<BoxShadow>? tableBoxShadow(
          {double? blurRadius, Offset? offset, Color? color}) =>
      [
        BoxShadow(
          color: color ?? MyColor.shadowColor,
          blurRadius: blurRadius ?? 8,
          offset: offset ?? const Offset(2, 4),
        )
      ];

  static List<BoxShadow>? buttonShadow(
          {double? blurRadius, Offset? offset, Color? color}) =>
      [
        BoxShadow(
          color: color ?? MyColor.shadowColor,
          blurRadius: blurRadius ?? 4,
          offset: offset ?? const Offset(0, 4),
        )
      ];

  static BoxDecoration roundedBottomDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          borderRadius: borderRadius ??
              BorderRadius.only(
                  bottomLeft: Radius.circular(radius ?? Sizes.RADIUS_80),
                  bottomRight: Radius.circular(radius ?? Sizes.RADIUS_80)),
          border: Border.all(
              color: borderColor ?? MyColor.white, width: borderWidth ?? 2));

  static BoxDecoration roundedTopDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          borderRadius: borderRadius ??
              BorderRadius.only(
                  topLeft: Radius.circular(radius ?? Sizes.RADIUS_80),
                  topRight: Radius.circular(radius ?? Sizes.RADIUS_80)),
          border: Border.all(
              color: borderColor ?? MyColor.white, width: borderWidth ?? 2));

  static OutlineInputBorder searchDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      OutlineInputBorder(
        borderSide:
            BorderSide(color: borderColor ?? MyColor.transparent, width: 1.5),
        borderRadius: BorderRadius.circular(radius ?? Sizes.RADIUS_80),
      );

  static RoundedRectangleBorder appBarShape(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Sizes.RADIUS_80),
              bottomRight: Radius.circular(Sizes.RADIUS_80)));

  static BoxDecoration floatingBoxDecoration(
          {Color? color,
          Color? borderColor,
          BoxShape? shape,
          BorderRadiusGeometry? borderRadius,
          double? radius,
          BoxBorder? border,
          double? borderWidth}) =>
      BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_80)),
        boxShadow: [
          BoxShadow(
            color: MyColor.floatingButtonColor.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: MyColor.floatingButtonColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      );
}
