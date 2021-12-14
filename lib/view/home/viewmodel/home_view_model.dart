import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/currency/currency_manager.dart';
import '../../../core/init/currency/currency_type.dart';
import '../../../core/init/lang/language_manager.dart';
import '../../_features/enums/separator_type.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/widgets/snackbar/snack_bar_helper.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/methods/number_to_characters/number_to_character.dart';
import '../../../core/base/model/base_view_model.dart';
import 'package:enum_to_string/enum_to_string.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel, SnackBarHelper {
  late final String _data;

  //GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late TextEditingController numberController;
  late TextEditingController resultController;
  List<SeparatorType> separatorTypeList = [SeparatorType.semicolon, SeparatorType.comma, SeparatorType.space];
  SeparatorType selectedSeparatorType = SeparatorType.semicolon;

  //language
  List<Locale> languageList = LanguageManager.instance.supportedLocales;
  Map languageMap = LanguageManager.instance.toDropdown();
  late NumberToCharacterConverter converter;// = NumberToCharacterConverter('en');
  Locale currentLocale = LanguageManager.instance.appLocale;
  String activeLanguagePath = LanguageManager.instance.getImagePath(LanguageManager.instance.appLocale.countryCode);

  //currency
  List<CurrencyType> currencyList = CurrencyManager.instance.supportedCurrencies;
  Map currencyMap = CurrencyManager.instance.toDropdown();
  CurrencyType currentCurrency = CurrencyManager.instance.appCurrency;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    _initInputs();

    currentCurrency = EnumToString.fromString(CurrencyType.values, localeManager.getStringValue(PreferencesKeys.currency)) ?? CurrencyType.dollar;
    converter = NumberToCharacterConverter(LanguageManager.instance.appLocale.countryCode!.toLowerCase());

    if (context != null && ModalRoute.of(context!)!.settings.arguments != null) {
      _data = ModalRoute.of(context!)!.settings.arguments as String;
      if (_data != '0') {
        numberController.text = _data;
        changeResult(_data);
      }
    }
  }

  void _initInputs() {
    numberController = TextEditingController(text: '');
    resultController = TextEditingController(text: '');
  }

  @action
  void changeResult(String value) {
    try {
      value = value.controlMaxNumber();
      var cursor = numberController.selection.baseOffset;
      numberController.text = value;
      numberController.selection = TextSelection(baseOffset: cursor, extentOffset: cursor);
      resultController.text = converter.convertDouble(value, currentCurrency).capitalize();
    } catch (e) {
      //print(e);
    }
  }

  void clearInputs() {
    numberController.text = '';
    resultController.text = '';
  }

  void copyToClipboard() {
    if (resultController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: resultController.text));
      showSnackMessage(scaffoldKey, LocaleKeys.text_copied.tr());
    }
  }

  Future<void> openCalculatorPage() async {
    await navigation.navigateToPage(path: NavigationConstants.calculatorView) as String;
  }

  Future<void> massUpload(SeparatorType selected) async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null && data.text!.isNotEmpty) {

      var buffer = StringBuffer();
      data.text!.split(selected.symbolValue).forEach((value) {
        value = value.onlyDecimal();
        var result = converter.convertDouble(value, currentCurrency);
        if (result.isNotEmpty) {
          buffer.write('$value\n${result.capitalize()}\n\n');
        }
      });

      if (buffer.toString().trim().isNotEmpty) {
        resultController.text = buffer.toString();
      } else {
        resultController.text = '';
      }
    }
    else {
      resultController.text = '';
    }

    //'100.50; 101.50; 102.50; aaaa; 104.50; 105.50; 106.50; 107.50'
  }

  Future<void> changeAppLocalization(Locale? locale) async {
    if (locale != null && LanguageManager.instance.supportedLocales.contains(locale)) {
      currentLocale = locale;
      activeLanguagePath = LanguageManager.instance.getImagePath(locale.countryCode);
      await localeManager.setStringValue(PreferencesKeys.localeLanguage, locale.languageCode);
      await localeManager.setStringValue(PreferencesKeys.localeCountry, locale.countryCode ?? '');
      await context?.setLocale(locale);
      LanguageManager.instance.appLocale = locale;
      clearInputs();
      converter = NumberToCharacterConverter(locale.countryCode!.toLowerCase());
    }
  }

  Future<void> changeAppCurrency(CurrencyType? currency) async {
    if (currency != null && CurrencyManager.instance.supportedCurrencies.contains(currency)) {
      currentCurrency = currency;
      await localeManager.setStringValue(PreferencesKeys.currency, EnumToString.convertToString(currency));
      CurrencyManager.instance.appCurrency = currency;
      clearInputs();
    }
  }
}
