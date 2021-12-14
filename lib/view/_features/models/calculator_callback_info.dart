class CalculatorCallbackInfo {
  String result;
  String Function(String) callback;

  CalculatorCallbackInfo({required this.result, required this.callback});
}