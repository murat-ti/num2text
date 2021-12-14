import 'package:flutter/material.dart';
import 'package:num2text/core/widgets/button/calculator_btn.dart';
import 'key_controller.dart';
import 'key_symbol.dart';
import 'key_event.dart' as key_event_local;

abstract class Keys {
  static KeySymbol clear = const KeySymbol('C');
  static KeySymbol sign = const KeySymbol('±');
  static KeySymbol percent = const KeySymbol('%');
  static KeySymbol divide = const KeySymbol('/');
  static KeySymbol multiply = const KeySymbol('*');
  static KeySymbol subtract = const KeySymbol('-');
  static KeySymbol add = const KeySymbol('+');
  static KeySymbol equals = const KeySymbol('=');
  static KeySymbol decimal = const KeySymbol('.');
  //static KeySymbol toCurrency = const KeySymbol('To Currency');
  static KeySymbol backSpace = const KeySymbol('⌫');

  static KeySymbol zero = const KeySymbol('0');
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
}

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({Key? key, required this.symbol}) : super(key: key);
  final KeySymbol symbol;
  static dynamic _fire(CalculatorKey key) => KeyController.fire(key_event_local.KeyEvent(key));

  @override
  Widget build(BuildContext context) {
    return CalculatorBtn(title: symbol.value, onPressed: () {_fire(this);});
  }
}
