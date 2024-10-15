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
  String _selectedOperation = 'Addition'; // Opération par défaut
  final TextEditingController _incrementController = TextEditingController();

  // Fonction pour mettre à jour l'incrément
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

  // Affiche une alerte si l'incrément est 0
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

  // Fonction pour effectuer l'opération mathématique
  void _performOperation() {
    setState(() {
      _clickCount++;
      switch (_selectedOperation) {
        case 'Addition':
          _counter += _increment;
          break;
        case 'Soustraction':
          _counter -= _increment;
          break;
        case 'Multiplication':
          _counter *= _increment;
          break;
        case 'Division':
          if (_increment != 0) {
            _counter = (_counter / _increment).floor(); // Utilisation de la division entière
          }
          break;
      }
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
            if (_clickCount > 0)
              Text(
                'Vous avez cliqué $_clickCount fois',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            const SizedBox(height: 20),

            // Widget d'affichage de l'opération
            ResultDisplay(counter: _counter, increment: _increment, operation: _selectedOperation),

            const SizedBox(height: 20),

            // Widget pour modifier l'incrément
            IncrementInput(
              controller: _incrementController,
              updateIncrement: _updateIncrement,
            ),

            const SizedBox(height: 20),

            // DropdownButton pour choisir l'opération
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: DropdownButton<String>(
                value: _selectedOperation,
                items: <String>['Addition', 'Soustraction', 'Multiplication', 'Division']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOperation = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _performOperation,
        tooltip: _selectedOperation,
        child: _getOperationIcon(), // Change icon dynamically
      ),
    );
  }

  // Fonction pour obtenir l'icône du FloatingActionButton en fonction de l'opération sélectionnée
  Icon _getOperationIcon() {
    switch (_selectedOperation) {
      case 'Soustraction':
        return const Icon(Icons.remove);
      case 'Multiplication':
        return const Icon(Icons.clear);
      case 'Division':
        return const Icon(Icons.horizontal_rule);
      default:
        return const Icon(Icons.add);
    }
  }
}
