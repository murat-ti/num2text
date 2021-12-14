import 'package:easy_localization/easy_localization.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:num2text/core/extension/string_extension.dart';
import 'package:num2text/core/init/currency/currency_type.dart';
import '../lang/locale_keys.g.dart';
import '../../constants/enums/locale_keys_enum.dart';
import '../cache/locale_manager.dart';

class CurrencyManager {
  static CurrencyManager? _instance;

  static CurrencyManager get instance {
    _instance ??= CurrencyManager._init();
    return _instance!;
  }

  CurrencyType? _appCurrency;
  int get defaultCurrencyIndex => 0;
  CurrencyType get appCurrency => _appCurrency ?? supportedCurrencies[defaultCurrencyIndex];
  set appCurrency(CurrencyType currency) => _appCurrency = currency;

  CurrencyManager._init() {
    var currency = EnumToString.fromString(CurrencyType.values, LocaleManager.instance.getStringValue(PreferencesKeys.currency)) ?? CurrencyType.dollar;
    _appCurrency = currency;
  }

  List<CurrencyType> get supportedCurrencies => [
        CurrencyType.dollar,
        CurrencyType.euro,
        CurrencyType.ruble,
        CurrencyType.manat
      ];

  Map toDropdown() {
    var currencyList = {};
    currencyList[0] = LocaleKeys.single_dollar.tr().capitalize();
    currencyList[1] = LocaleKeys.single_euro.tr().capitalize();
    currencyList[2] = LocaleKeys.single_ruble.tr().capitalize();
    currencyList[3] = LocaleKeys.single_manat.tr().capitalize();
    return currencyList;
  }
}
