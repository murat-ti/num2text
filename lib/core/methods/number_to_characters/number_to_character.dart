library number_to_text_converter;

import '../../extension/int_extension.dart';
import '../../extension/string_extension.dart';
import '../../init/currency/currency_type.dart';
import 'segment_model.dart';
import 'number_mappings.dart';

late NumberSplitter _numberSplitter;
late NumberMappings _numberMappings;
late String langu;
late String currency;

class NumberToCharacterConverter {
  NumberToCharacterConverter(String lang) {
    if (lang == 'us') lang = 'en';

    _numberSplitter = InternationalNumberingSystemNumberSplitter();
    _numberMappings = NumberMappings(lang);
    langu = lang;
  }

  String convertInt(int? number) {
    if (number == null) return '';
    return getTextForNumber(number);
  }

  String convertDouble(String? numberText, CurrencyType currency) {
    if (numberText == null) return '';

    int firstNumber = 0;
    int secondNumber = 0;

    try {
      var splitNumber = numberText.toString().split('.');

      if (splitNumber[0].isNotEmpty) {
        firstNumber = int.parse(splitNumber[0]);
      }

      if (splitNumber[1].isNotEmpty) {
        if (splitNumber[1].length > 2) {
          secondNumber = int.parse(splitNumber[1].substring(0, 2));
        } else {
          secondNumber = int.parse(splitNumber[1]);
        }
      }

      if (secondNumber > 100) {
        secondNumber = (secondNumber / 10).round();
      }

      String numberInCharacters = '';

      //.03 => 3 and 3 => 30
      if (secondNumber.toString().length == 1) {
        secondNumber *= 10;
      }

      var firstPart = 'dollar';
      var secondPart = 'cent';

      firstPart = ''.declination(firstNumber, currency);
      secondPart = ''.declination(secondNumber, currency, isMainUnit: false);

      if (firstNumber > 0) {
        var tempFirst = getTextForNumber(firstNumber);
        if(langu == 'ru' && firstNumber >= 1000) {// && firstNumber < 3000
          if(firstNumber >= 1000 && firstNumber < 2000) {
            tempFirst = tempFirst.replaceAll('один тысяча', 'одна тысяча');
          }
          if(firstNumber >= 2000) {//&& firstNumber < 3000
            tempFirst = tempFirst.replaceAll('два тысячи', 'две тысячи');
          }
        }
        numberInCharacters += tempFirst + ' ' + firstPart;
      }

      if (secondNumber > 0 && secondNumber < 100) {
        var temp = secondNumber % 10;
        if (temp == 0 || (secondNumber > 0 && secondNumber < 20)) {
          numberInCharacters += ' ' + getTextForNumber(secondNumber) + ' ' + secondPart;
        } else {
          var tensDelimeter = ' ';
          if (langu == 'en') {
            tensDelimeter = '-';
          }

          var secTemp = getTextForNumber(temp);
          if(langu == 'ru' && temp == 2 && currency == CurrencyType.ruble) {
            secTemp = 'две';
          }

          numberInCharacters +=
              ' ' + getTextForNumber(secondNumber - temp) + tensDelimeter + secTemp + ' ' + secondPart;
        }
      }

      return numberInCharacters.replaceAll('  ', ' ');
    } catch (ex) {
      //print('catch $ex');
      return '';
    }
  }

  String getTextForNumber(int number) {
    var segments = _numberSplitter.splitNumber(number);
    var text = '';
    var tensDelimeter = ' ';

    for (int i = 0; i < segments.length; i++) {
      var part = segments[i];

      //20, 30 ... 90 you need add -
      if (langu == 'en' && part.number > 20 && part.number < 100 && part.number % 10 != 0) {
        tensDelimeter = '-';
      } else {
        tensDelimeter = ' ';
      }

      var partString = getTextForNumberLessThan1000(part.number);
      var shouldAddSpace = text.isNotEmpty && partString.isNotEmpty;

      if (shouldAddSpace) text += ' ';
      text += partString.replaceAll(' ', tensDelimeter) + part.magnitude;
    }

    return text;
  }

  String getTextForNumberLessThan1000(int number) {
    if (number > 999) return '';

    var lastTwoDigits = (number % 100).toInt();
    var lastTwoDigitsText = getTextForNumberLessThan100(lastTwoDigits);

    var digitAtHundredsPlace = number ~/ 100;

    var hundredsPlaceText = getMappingForNumber(digitAtHundredsPlace);
    if (hundredsPlaceText.isNotEmpty) {
      String aa = ' '; //hundred

      if (langu == 'ru') {
        hundredsPlaceText = ''; //Odin sto nepravilno, nado prosto sto
      }

      if (langu == 'ru' && (digitAtHundredsPlace > 1 && digitAtHundredsPlace < 10)) {
        aa += _numberMappings.mappings[digitAtHundredsPlace * 100].toString();
        hundredsPlaceText = aa;
      } else {
        aa += _numberMappings.mappings[100].toString();
        hundredsPlaceText += aa;
      }
    }

    if (hundredsPlaceText.isNotEmpty && lastTwoDigitsText.isNotEmpty) {
      String aa = _numberMappings.mappings[0].toString() + ' '; //and
      hundredsPlaceText += aa;
    }

    return hundredsPlaceText + lastTwoDigitsText;
  }

  String getTextForNumberLessThan100(int number) {
    if (number > 99) return '';
    if (getMappingForNumber(number).isNotEmpty) {
      return getMappingForNumber(number);
    }

    var onesPlace = (number % 10).toInt();
    var onesPlaceText = getMappingForNumber(onesPlace);

    var tensPlace = ((number - onesPlace) % 100).toInt();
    var tensPlaceText = getMappingForNumber(tensPlace);

    if (onesPlaceText.isNotEmpty) tensPlaceText += ' ';

    /*if(langu =='en'){
      return onesPlaceText +" "+_numberMappings.mappings[0].toString()+" "+ tensPlaceText ;
    }*/
    return tensPlaceText + onesPlaceText;
  }

  String getMappingForNumber(int number) {
    if (number == 0 || !_numberMappings.mappings.containsKey(number)) return '';
    return _numberMappings.mappings[number];
  }
}

// interface of splitter
abstract class NumberSplitter {
  List<SegmentModel> splitNumber(int number);
}

//there is another splits like indian numbers or old arabic numbers
class InternationalNumberingSystemNumberSplitter extends NumberSplitter {
  @override
  List<SegmentModel> splitNumber(int number) {
    var separatedNumbersList = number.toString().split("");
    List<SegmentModel> segments = [];
    var numberString = '';
    for (int i = separatedNumbersList.length - 1; i >= 0; i--) {
      numberString = separatedNumbersList[i] + numberString;
      if (numberString.length == 3 || i == 0) {
        var segment = _getSegmentForNumber(numberString, segments.length);
        segments.insert(0, segment);
        numberString = '';
      }
    }

    return segments.toList();
  }

  /*SegmentModel specialSegment(int number, String magnitude) {
    return SegmentModel(number, magnitude);
  }*/

  SegmentModel _getSegmentForNumber(String numberString, int noOfExistingSegments) {
    var number = int.parse(numberString);
    var magnitude = _getOrderOfMagnitudeOfSegment(number, noOfExistingSegments);
    //print("$number-----------------------------------------------------$magnitude");
    return SegmentModel(number, magnitude);
  }

  String _getOrderOfMagnitudeOfSegment(int segment, int? indexOfSegment) {
    var magnitude = '';

    if (indexOfSegment != null) {
      if (segment != 0 && indexOfSegment % 6 == 1) {
        magnitude = ' ' + _numberMappings.mappings[1000.declination(segment, langu)] + ' ';
      } //thousand
      if (segment != 0 && indexOfSegment % 6 == 2) {
        magnitude = ' ' + _numberMappings.mappings[10000.declination(segment, langu)];
      } //million
      if (segment != 0 && indexOfSegment % 6 == 3) {
        magnitude = ' ' + _numberMappings.mappings[100000.declination(segment, langu)];
      } //billion
      if (segment != 0 && indexOfSegment % 6 == 4) {
        magnitude = ' ' + _numberMappings.mappings[1000000.declination(segment, langu)];
      } //trillion
      if (segment != 0 && indexOfSegment % 6 == 5) {
        magnitude = ' ' + _numberMappings.mappings[10000000.declination(segment, langu)];
      } //quadrillion
      if (indexOfSegment > 0 && indexOfSegment % 6 == 0) {
        magnitude = ' ' + _numberMappings.mappings[100000000.declination(segment, langu)];
      } //quintrillion
    }
    return magnitude;
  }
}
