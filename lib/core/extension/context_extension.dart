import 'dart:math';
import 'package:flutter/material.dart';
import '../utility/page_animation/slider_route.dart';


extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get appTheme => Theme.of(this);

  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;

  double get normalValue => height * 0.02;

  double get mediumValue => height * 0.04;

  double get highValue => height * 0.1;

  double dynamicWidth(double val) => width * val;

  double dynamicHeight(double val) => height * val;
}

extension DurationExtension on BuildContext {
  Duration get durationLow => const Duration(milliseconds: 500);

  Duration get durationNormal => const Duration(seconds: 1);

  Duration get durationSlow => const Duration(seconds: 5);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get horizontalPaddingMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get horizontalPaddingHigh => EdgeInsets.symmetric(horizontal: highValue);

  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get verticalPaddingNormal => EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get verticalPaddingMedium => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get verticalPaddingHigh => EdgeInsets.symmetric(vertical: highValue);
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);

  Radius get normalRadius => Radius.circular(width * 0.05);

  Radius get mediumRadius => Radius.circular(width * 0.03);

  Radius get highRadius => Radius.circular(width * 0.1);
}

extension BorderExtension on BuildContext {
  BorderRadius get normalBorderRadius => BorderRadius.all(normalRadius);

  BorderRadius get lowBorderRadius => BorderRadius.all(lowRadius);

  BorderRadius get mediumBorderRadius => BorderRadius.all(mediumRadius);

  BorderRadius get highBorderRadius => BorderRadius.all(highRadius);

  RoundedRectangleBorder get roundedRectangleTopBorderLow =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: lowRadius));

  RoundedRectangleBorder get roundedRectangleTopBorderNormal =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: normalRadius));

  RoundedRectangleBorder get roundedRectangleTopBorderMedium =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: mediumRadius));

  RoundedRectangleBorder get roundedRectangleTopBorderHigh =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: highRadius));

  BorderRadius get borderRadiusCircularLow => BorderRadius.circular(lowValue);
  BorderRadius get borderRadiusCircularNormal => BorderRadius.circular(normalValue);
  BorderRadius get borderRadiusCircularMedium => BorderRadius.circular(mediumValue);
  BorderRadius get borderRadiusCircularHigh => BorderRadius.circular(highValue);

  RoundedRectangleBorder get roundedRectangleAllBorderLow =>
      RoundedRectangleBorder(borderRadius: borderRadiusCircularLow);

  RoundedRectangleBorder get roundedRectangleAllBorderNormal =>
      RoundedRectangleBorder(borderRadius: borderRadiusCircularNormal);

  RoundedRectangleBorder get roundedRectangleAllBorderMedium =>
      RoundedRectangleBorder(borderRadius: borderRadiusCircularMedium);

  RoundedRectangleBorder get roundedRectangleAllBorderHigh =>
      RoundedRectangleBorder(borderRadius: borderRadiusCircularHigh);
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigation => Navigator.of(this);

  Future<void> pop() async {
    await navigation.maybePop();
  }

  Future<T?> navigateName<T>(String path, {Object? data}) async {
    return await navigation.pushNamed<T>(path, arguments: data);
  }

  Future<T?> navigateToReset<T>(String path, {Object? data}) async {
    return await navigation.pushNamedAndRemoveUntil(path, (route) => false, arguments: data);
  }

  Future<dynamic> navigateToPage(Widget page, {Object? extra, SlideType type = SlideType.primary}) async {
    return await navigation.push(type.route(page, RouteSettings(arguments: extra)));
  }
}

extension IconSizeExtension on BuildContext {
  double get iconLowSize => 18;

  double get iconNormalSize => 24;

  double get iconHighSize => 30;
}

extension FontSizeExtension on BuildContext {
  double get fontExtraLowSize => 12;

  double get fontLowSize => 14;

  double get fontNormalSize => 16;

  double get fontHighSize => 20;
}
