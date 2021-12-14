import 'package:flutter/material.dart';
import '../../../core/methods/calculator/processor.dart';
import 'display.dart';
import '../../../core/methods/calculator/key_controller.dart';
import 'key_pad.dart';

class CalculatorView extends StatefulWidget {

  const CalculatorView({ Key? key }) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorView> {

  String _output = '';

  @override
  void initState() {
    KeyController.listen((event) => Processor.process(event));
    Processor.listen((data) => setState(() { _output = data; }));
    Processor.refresh();
    super.initState();
  }

  @override
  void dispose() {

    KeyController.dispose();
    Processor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Display(value: _output)),
            const KeyPad()
          ]
      ),
    );
  }
}