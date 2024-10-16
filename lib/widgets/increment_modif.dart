import 'package:flutter/material.dart';

class IncrementInput extends StatelessWidget {
  final TextEditingController controller;
  final Function updateIncrement;

  const IncrementInput({
    super.key,
    required this.controller,
    required this.updateIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number, // Forcer la saisie numérique
            decoration: const InputDecoration(
              labelText: 'Entrez la valeur de l\'incrément',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => updateIncrement(), // Appelle la fonction de mise à jour
          child: const Text('Mettre à jour l\'incrément'),
        ),
      ],
    );
  }
}
