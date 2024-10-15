import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final int counter;
  final int increment;
  final String operation;

  const ResultDisplay({
    Key? key,
    required this.counter,
    required this.increment,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String operationSymbol;
    int result;

    // Choisir le symbole de l'opération et calculer le résultat
    switch (operation) {
      case 'Addition':
        operationSymbol = '+';
        result = counter + increment;
        break;
      case 'Soustraction':
        operationSymbol = '-';
        result = counter - increment;
        break;
      case 'Multiplication':
        operationSymbol = '×';
        result = counter * increment;
        break;
      case 'Division':
        operationSymbol = '/';
        result = increment != 0 ? (counter / increment).floor() : 0;
        break;
      default:
        operationSymbol = '+';
        result = counter + increment;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$counter $operationSymbol $increment =',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(width: 10),
        Text(
          '$result',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
