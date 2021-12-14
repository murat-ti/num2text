import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/widgets/button/calculator_btn.dart';
import '../../../core/base/view/base_widget.dart';
import '../viewmodel/calculator_view_model.dart';
import '_part/display.dart';
import '_part/key_pad.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CalculatorViewModel>(
      viewModel: CalculatorViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onDispose: (model) {
        model.dispose();
      },
      onPageBuilder: (BuildContext context, CalculatorViewModel viewModel) => Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Expanded(child: Observer(builder: (_) => Display(value: viewModel.output))),
          const KeyPad(),
          Row(children: <Widget>[
            CalculatorBtn(
              title: 'To Currency',
              onPressed: () {
                viewModel.convertOutput();
              },
            ),
          ]),
          //Container(height: 60, color: Colors.red),
        ]),
      ),
    );
  }
}
