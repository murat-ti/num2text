import 'package:easy_localization/easy_localization.dart';
import '../init/currency/currency_type.dart';
import '../init/lang/locale_keys.g.dart';

extension StringExtension on String {
  String controlMaxNumber() {
    String result = this;
    int firstNumber = 0;
    int secondNumber = 0;

    if (result.contains('.')) {
      var splitNumber = result.toString().split('.');

      if (splitNumber[0].isNotEmpty) {
        if (splitNumber[0].length > 18) {
          splitNumber[0] = splitNumber[0].substring(0, 18);
        }
        firstNumber = int.parse(splitNumber[0]);
      }

      if (splitNumber.length == 2 && splitNumber[1].isNotEmpty) {
        if (splitNumber[1].length > 2) {
          secondNumber = int.parse(splitNumber[1].substring(0, 2));
        } else {
          secondNumber = int.parse(splitNumber[1]);
        }
      }
    } else {
      if (result.isNotEmpty) {
        if (result.length > 18) {
          result = result.substring(0, 18);
        }
        firstNumber = int.parse(result);
        secondNumber = 0;
      }
    }
    return "$firstNumber.$secondNumber";
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String onlyDecimal() {
    return replaceAll(RegExp('[^\\d.]'), '');
  }

  String declination(int number, CurrencyType currency, {isMainUnit = true}) {
    String result = '-';
    switch (number % 10) {
      case 2:
      case 3:
      case 4:
        switch (currency) {
          case CurrencyType.euro:
            result = isMainUnit ? LocaleKeys.plural_euro : LocaleKeys.plural_cents;
            break;
          case CurrencyType.manat:
            result = isMainUnit ? LocaleKeys.plural_manats : LocaleKeys.single_tenge;
            break;
          case CurrencyType.ruble:
            result = isMainUnit ? LocaleKeys.plural_rubles : LocaleKeys.plural_kopecks;
            break;
          default:
            result = isMainUnit ? LocaleKeys.plural_dollars : LocaleKeys.plural_cents;
            break;
        }
        break;
      case 0:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
        switch (currency) {
          case CurrencyType.euro:
            result = isMainUnit ? LocaleKeys.plural_euro : LocaleKeys.plural_cents;
            break;
          case CurrencyType.manat:
            result = isMainUnit ? LocaleKeys.single_manat : LocaleKeys.single_tenge;
            break;
          case CurrencyType.ruble:
            result = isMainUnit ? LocaleKeys.plural_rubles1 : LocaleKeys.plural_kopecks1;
            break;
          default:
            result = isMainUnit ? LocaleKeys.plural_dollars : LocaleKeys.plural_cents;
            break;
        }
        break;
      default:
        switch (currency) {
          case CurrencyType.euro:
            result = isMainUnit ? LocaleKeys.single_euro : LocaleKeys.single_cent;
            break;
          case CurrencyType.manat:
            result = isMainUnit ? LocaleKeys.single_manat : LocaleKeys.single_tenge;
            break;
          case CurrencyType.ruble:
            result = isMainUnit ? LocaleKeys.single_ruble : LocaleKeys.single_kopeck;
            break;
          default:
            result = (number > 1)
                ? isMainUnit
                    ? LocaleKeys.plural_dollars
                    : LocaleKeys.plural_cents
                : isMainUnit
                    ? LocaleKeys.single_dollar
                    : LocaleKeys.single_cent;
            break;
        }
        break;
    }
    return result.tr();
  }
}
