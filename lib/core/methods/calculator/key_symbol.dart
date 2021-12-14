import 'calculator_key.dart';

enum KeyType { function, operator, integer }

class KeySymbol {

  const KeySymbol(this.value);
  final String value;

  static final List<KeySymbol> _functions = [ Keys.clear, Keys.backSpace, Keys.sign, Keys.percent, Keys.decimal ];
  static final List<KeySymbol> _operators = [ Keys.divide, Keys.multiply, Keys.subtract, Keys.add, Keys.equals ];//, Keys.toCurrency

  @override
  String toString() => value;

  bool get isOperator => _operators.contains(this);
  bool get isFunction => _functions.contains(this);
  bool get isInteger => !isOperator && !isFunction;

  KeyType get type => isFunction ? KeyType.function : (isOperator ? KeyType.operator : KeyType.integer);
}