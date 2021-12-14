import 'package:flutter/material.dart';

class CalculatorBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const CalculatorBtn({Key? key, this.title, this.onPressed}) : super(key: key);

  final TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 20);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1),width: 0.5)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title ?? '',
            style: style,
          ),
          padding: padding,
          highlightColor: Colors.blueGrey[100],
          splashColor: Colors.blueAccent[100],
        ),
      ),
    );
  }
}
