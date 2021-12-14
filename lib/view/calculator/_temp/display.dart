import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  const Display({Key? key, required this.value}) : super(key: key);
  final String value;
  String get _output => value.toString();
  final TextStyle style = const TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  final EdgeInsets padding = const EdgeInsets.all(30);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: padding,
      child: Text(
        _output,
        style: style,
      ),
    );
  }
}
