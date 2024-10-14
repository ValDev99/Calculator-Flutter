import 'package:flutter/material.dart';
import 'widgets/result_display.dart';
import 'widgets/increment_modif.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _increment = 2;
  int _clickCount = 0;
  final TextEditingController _incrementController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter += _increment;
      _clickCount++;
    });
  }

  void _updateIncrement() {
    final String inputText = _incrementController.text;

    if (inputText.isNotEmpty && int.tryParse(inputText) != null) {
      final int newIncrement = int.parse(inputText);

      if (newIncrement == 0) {
        _showAlert();
        setState(() {
          _increment = 1;
        });
      } else {
        setState(() {
          _increment = newIncrement;
        });
      }
    }
  }

  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Valeur incorrecte'),
          content: const Text("La valeur de l'incrément ne peut pas être 0. Elle a été changée à 1."),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            if (_clickCount > 0)
              Text(
                'Vous avez cliqué $_clickCount fois',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            const SizedBox(height: 20),
            ResultDisplay(counter: _counter, increment: _increment),
            const SizedBox(height: 20),

            // Utilisation du nouveau widget IncrementInput
            IncrementInput(
              controller: _incrementController,
              updateIncrement: _updateIncrement,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Text(
          '+$_increment', // Affiche dynamiquement la valeur de l'incrément
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
