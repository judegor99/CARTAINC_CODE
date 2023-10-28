import 'package:carta_inc/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'agrega.dart';
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class FoodItem {
  final String foodType;
  final String subOptionName;
  final String name;
  final String description;
  final double price;
  final String image;

  FoodItem({
    required this.foodType,
    required this.subOptionName,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreaMenuScreen(),
    );
  }
}

class CreaMenuScreen extends StatelessWidget {
  final Map<String, String> options = {
    'Entradas': 'images/entradas.jpg',
    'Platos fuertes': 'images/platos_fuertes.jpg',
    'Postres': 'images/postres.jpg',
    'Bebidas': 'images/bebidas.jpg',
    'Otros': 'images/otros.jpg',
  };

  CreaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''), // Elimina el título actual
        leading: IconButton( // Botón de retroceso
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()), // Reemplaza CreaMenuScreen con el nombre correcto de tu clase en crea.dart
            );
            // Agregar aquí la navegación para retroceder
          },
        ),
        actions: [
          IconButton( // Botón para ir a la pantalla principal
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()), // Reemplaza CreaMenuScreen con el nombre correcto de tu clase en crea.dart
              );
              // Agregar aquí la navegación a la pantalla principal
            },
          ),
          IconButton( // Botón para ir al menú
            icon: const Icon(Icons.menu_book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccedeMenuScreen(menuItems: [],)), // Reemplaza CreaMenuScreen con el nombre correcto de tu clase en crea.dart
              );
              // Agregar aquí la navegación a la pantalla del menú
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/FONDO_CREA.jpg'), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Ajustar la imagen al tamaño del contenedor
          ),
        ),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 40,),
              _buildOptionButton(context, 'Entradas'),
              _buildOptionButton(context, 'Platos fuertes'),
              _buildOptionButton(context, 'Postres'),
              _buildOptionButton(context, 'Bebidas'),
              _buildOptionButton(context, 'Otros'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String option) {
    final String optionImage = options[option]!;

    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: GestureDetector(
        onTap: () {
          final menuState = Provider.of<MenuState>(context, listen: false);
          // Agrega la sección al menú con el nombre de la opción
          menuState.addSectionWithName(option);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgregaScreen(
                subOptionInfo: SubOptionInfo(
                  foodType: option,
                  subOptionName: 'NombrePorDefecto',
                  subOptionImage: optionImage,
                ),
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Image.asset(
              optionImage,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    option.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
