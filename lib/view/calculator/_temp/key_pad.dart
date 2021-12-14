import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/methods/calculator/calculator_key.dart';

class KeyPad extends StatelessWidget {
  const KeyPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: <Widget>[
        CalculatorKey(symbol: Keys.clear),
        CalculatorKey(symbol: Keys.backSpace),
        CalculatorKey(symbol: Keys.percent),
        CalculatorKey(symbol: Keys.divide),
      ]),
      Row(children: <Widget>[
        CalculatorKey(symbol: Keys.seven),
        CalculatorKey(symbol: Keys.eight),
        CalculatorKey(symbol: Keys.nine),
        CalculatorKey(symbol: Keys.multiply),
      ]),
      Row(children: <Widget>[
        CalculatorKey(symbol: Keys.four),
        CalculatorKey(symbol: Keys.five),
        CalculatorKey(symbol: Keys.six),
        CalculatorKey(symbol: Keys.subtract),
      ]),
      Row(children: <Widget>[
        CalculatorKey(symbol: Keys.one),
        CalculatorKey(symbol: Keys.two),
        CalculatorKey(symbol: Keys.three),
        CalculatorKey(symbol: Keys.add),
      ]),
      Row(children: <Widget>[
        CalculatorKey(symbol: Keys.sign),
        CalculatorKey(symbol: Keys.zero),
        CalculatorKey(symbol: Keys.decimal),
        CalculatorKey(symbol: Keys.equals),
      ]),
    ]);
  }
}
