import 'package:flutter/material.dart';
import 'widgets/result_display.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _increment = 2;
  int _howMuchClick = 0;

  void _incrementCounter() {
    setState(() {
      _counter += _increment;
      _howMuchClick++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_howMuchClick > 0)
              Text(
                'Vous avez cliqué $_howMuchClick fois',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            const SizedBox(height: 20), // Ajouter un espace entre les deux textes
            ResultDisplay(counter: _counter, increment: _increment),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Text(
          '+2',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
