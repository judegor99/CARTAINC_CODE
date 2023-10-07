import 'package:flutter/material.dart';

class CreaMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea tu menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Acción cuando se presiona "Comida asiática"
                _handleOptionSelected(context, 'Comida asiática');
              },
              child: Text('Comida asiática'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción cuando se presiona "Comida mexicana"
                _handleOptionSelected(context, 'Comida mexicana');
              },
              child: Text('Comida mexicana'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción cuando se presiona "Comida italiana"
                _handleOptionSelected(context, 'Comida italiana');
              },
              child: Text('Comida italiana'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción cuando se presiona "Otra comida"
                _handleOptionSelected(context, 'Otra comida');
              },
              child: Text('Otra comida'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOptionSelected(BuildContext context, String option) {
    // Aquí puedes realizar acciones basadas en la opción seleccionada
    // Por ejemplo, mostrar un mensaje con la opción seleccionada.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Opción seleccionada'),
          content: Text(option),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
