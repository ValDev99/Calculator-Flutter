import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';

class ResultDisplay extends StatelessWidget {
  final int counter;
  final int increment;

  const ResultDisplay({Key? key, required this.counter, required this.increment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$counter + $increment =',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          '${counter + increment}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
