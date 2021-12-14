import 'package:easy_localization/easy_localization.dart';
import '../../../core/init/lang/locale_keys.g.dart';

enum SeparatorType { semicolon, comma, space }
extension SeparatorTypeExtension on SeparatorType {
  String get rawValue {
    switch (this) {
      case SeparatorType.semicolon: return LocaleKeys.mass_convert_semicolon.tr();
      case SeparatorType.comma: return LocaleKeys.mass_convert_comma.tr();
      case SeparatorType.space: return LocaleKeys.mass_convert_space.tr();
    }
  }

  String get hintValue {
    String hint = '100.50# 101.50# 102.50# 103.50';
    switch (this) {
      case SeparatorType.semicolon: return hint.replaceAll('#', symbolValue);
      case SeparatorType.comma: return hint.replaceAll('#', symbolValue);
      case SeparatorType.space: return hint.replaceAll('#', symbolValue);
    }
  }

  String get symbolValue {
    switch (this) {
      case SeparatorType.semicolon: return ';';
      case SeparatorType.comma: return ',';
      case SeparatorType.space: return ' ';
    }
  }

  String get sampleValue {
    switch (this) {
      case SeparatorType.semicolon: return LocaleKeys.mass_convert_semicolon.tr();
      case SeparatorType.comma: return LocaleKeys.mass_convert_comma.tr();
      case SeparatorType.space: return LocaleKeys.mass_convert_space.tr();
    }
  }
}