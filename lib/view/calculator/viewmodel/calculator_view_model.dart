import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:num2text/core/constants/navigation/navigation_constants.dart';
import '../../../core/methods/calculator/key_controller.dart';
import '../../../core/methods/calculator/processor.dart';
import '../../../core/base/model/base_view_model.dart';
part 'calculator_view_model.g.dart';

class CalculatorViewModel = CalculatorViewModelBase with _$CalculatorViewModel;

abstract class CalculatorViewModelBase with Store, BaseViewModel {

  @observable
  String output = '';

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    output = '';
    KeyController.listen((event) => Processor.process(event));
    Processor.listen((data) => output = data); //; output = data
    Processor.refresh();
  }

  void dispose() {
    KeyController.dispose();
    Processor.dispose();
  }

  Future<void> convertOutput() async {
    if (context != null) {
      await navigation.navigateToPageClear(path: NavigationConstants.homeView, data: output);
    }
  }
}