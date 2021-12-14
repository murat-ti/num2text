import 'dart:async';
import 'calculator_key.dart';
import 'key_event.dart';
import 'key_symbol.dart';

abstract class Processor {
  static KeySymbol? _operator;
  static String _valA = '0';
  static String _valB = '0';
  static String? _result;

  static StreamController _controller = StreamController();

  static Stream get _stream => _controller.stream;

  static StreamSubscription listen(dynamic handler) {
    if(_controller.isClosed) {
      _controller = StreamController();
    }
    return _stream.listen(handler as dynamic);
  }

  static void refresh() => _fire(_output);

  //static void _fire(String data) => _controller.add(_output);
  static void _fire(String data) {
    if(!_controller.isClosed) {
      _controller.add(_output);
    }
  }

  static String get _output => _result ?? _equation;

  static String get _equation =>
      _valA + (_operator != null ? ' ' + _operator!.value : '') + (_valB != '0' ? ' ' + _valB : '');

  static dispose() {
    _valA = '0';
    _result = null;
    _condense();
    return _controller.close();
  }

  static process(dynamic event) {
    CalculatorKey key = (event as KeyEvent).key;
    switch (key.symbol.type) {
      case KeyType.function:
        return handleFunction(key);

      case KeyType.operator:
        return handleOperator(key);

      case KeyType.integer:
        return handleInteger(key);
    }
  }

  static void handleFunction(CalculatorKey key) {
    if (_valA == '0') {
      return;
    }
    if (_result != null) {
      _condense();
    }

    Map<KeySymbol, dynamic> table = {
      Keys.clear: () => _clear(),
      Keys.backSpace: () => _backSpace(),
      Keys.sign: () => _sign(),
      Keys.percent: () => _percent(),
      Keys.decimal: () => _decimal(),
    };

    table[key.symbol]();
    refresh();
  }

  static void handleOperator(CalculatorKey key) {
    if (_valA == '0') {
      return;
    }

    /*if (key.symbol == Keys.toCurrency) {
      return _toCurrency();
    }*/

    if (key.symbol == Keys.equals) {
      return _calculate();
    }
    if (_result != null) {
      _condense();
    }

    _operator = key.symbol;
    refresh();
  }

  static void handleInteger(CalculatorKey key) {
    String val = key.symbol.value;
    if (_operator == null) {
      _valA = (_valA == '0') ? val : _valA + val;
    } else {
      _valB = (_valB == '0') ? val : _valB + val;
    }
    refresh();
  }

  static void _clear() {
    _valA = _valB = '0';
    _operator = _result = null;
  }

  /*static void _toCurrency() {
    _condense();
    print('_toCurrency');
    print('_valA $_valA');
    print('_result $_result');
  }*/

  static void _backSpace() {
    if (_valB != '0' && _valB.isNotEmpty) {
      _valB = _valB.substring(0, _valB.length - 1);
      if (_valB.isEmpty) {
        _valB = '0';
      }
    } else if (_valB == '0' && _operator != null) {
      _operator = null;
    } else if (_valB == '0' && _operator == null && _valA != '0' && _valA.isNotEmpty) {
      _valA = _valA.substring(0, _valA.length - 1);
      if (_valA.isEmpty) {
        _valA = '0';
      }
    }
  }

  static void _sign() {
    if (_valB != '0') {
      _valB = (_valB.contains('-') ? _valB.substring(1) : '-' + _valB);
    } else if (_valA != '0') {
      _valA = (_valA.contains('-') ? _valA.substring(1) : '-' + _valA);
    }
  }

  static String calcPercent(String x) => (double.parse(x) / 100).toString();

  static void _percent() {
    if (_valB != '0' && !_valB.contains('.')) {
      _valB = calcPercent(_valB);
    } else if (_valA != '0' && !_valA.contains('.')) {
      _valA = calcPercent(_valA);
    }
  }

  static void _decimal() {
    if (_valB != '0' && !_valB.contains('.') || (_operator != null &&  !_valB.contains('.'))) {
      _valB = _valB + '.';
    } else if (_valA != '0' && !_valA.contains('.') || (_operator == null && !_valA.contains('.'))) {
      _valA = _valA + '.';
    }
  }

  static void _calculate() {
    if (_operator == null || _valB == '0') {
      return;
    }

    Map<KeySymbol, dynamic> table = {
      Keys.divide: (a, b) => (a / b),
      Keys.multiply: (a, b) => (a * b),
      Keys.subtract: (a, b) => (a - b),
      Keys.add: (a, b) => (a + b)
    };

    double result = table[_operator](double.parse(_valA), double.parse(_valB));
    String str = result.toString();

    while ((str.contains('.') && str.endsWith('0')) || str.endsWith('.')) {
      str = str.substring(0, str.length - 1);
    }

    _result = str;
    refresh();
  }

  static void _condense() {
    _valA = _result ?? _valA;
    _valB = '0';
    _result = _operator = null;
  }
}
