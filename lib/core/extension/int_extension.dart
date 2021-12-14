import 'package:easy_localization/easy_localization.dart';
import 'package:num2text/core/init/currency/currency_type.dart';
import 'package:num2text/core/init/lang/locale_keys.g.dart';

extension IntExtension on int {
  int declination(int segment, String language) {
    var temp = this;
    if(language == 'ru'){
      if(temp >= 10000) {
        if(segment == 1) {
            temp = this;
        }
        else if (segment > 1 && segment < 5) {
          temp += 1;
        }
        else {
          temp += 2;
        }
      }
      else {
        if (segment == 1) {
          temp += 1;
        } else if (segment > 1 && segment < 5) {
          temp += 2;
        }
        else {
          temp = this;
        }
      }
    }
    return temp;
  }
}