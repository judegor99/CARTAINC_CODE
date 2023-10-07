import 'package:flutter/material.dart';
import 'crea.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro para la interfaz
      appBar: AppBar(
        backgroundColor: Colors.black, // Fondo negro para la AppBar
        title: Text(
          'CARTA INC',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        elevation: 0, // Quitar sombra del appBar
      ),
      body: Column(
        children: [
          Container(
            height: 2.0, // Altura de la línea divisoria
            color: Colors.white, // Color de la línea divisoria (blanco)
          ),
          Expanded(
            child: Center(
              child: GridView.count(
                crossAxisCount: 2, // Dos columnas
                mainAxisSpacing: 20.0, // Espacio vertical entre los botones
                crossAxisSpacing: 20.0, // Espacio horizontal entre los botones
                padding: EdgeInsets.all(20.0), // Margen alrededor de los botones
                children: <Widget>[
                  // Botón 1: Crear tu menu
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de Crear tu menu
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreaMenuScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Fondo blanco para los botones
                      onPrimary: Colors.black, // Texto negro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Curvatura de las esquinas
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.create, size: 48.0), // Icono más grande
                        SizedBox(height: 8.0),
                        Text('Crear tu menu'), // Texto abajo del icono
                      ],
                    ),
                  ),

                  // Botón 2: Accede a tu menu (Mantenido igual)
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de Accede a tu menu
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AccedeMenuScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Fondo blanco para los botones
                      onPrimary: Colors.black, // Texto negro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Curvatura de las esquinas
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.accessibility, size: 48.0), // Icono más grande
                        SizedBox(height: 8.0),
                        Text('Accede a tu menu'), // Texto abajo del icono
                      ],
                    ),
                  ),

                  // Botón 3: Configura tu menu (Mantenido igual)
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de Configura tu menu
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfiguraMenuScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Fondo blanco para los botones
                      onPrimary: Colors.black, // Texto negro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Curvatura de las esquinas
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: 48.0), // Icono más grande
                        SizedBox(height: 8.0),
                        Text('Configura tu menu'), // Texto abajo del icono
                      ],
                    ),
                  ),

                  // Botón 4: Genera tu menu (Mantenido igual)
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de Genera tu menu
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GeneraMenuScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Fondo blanco para los botones
                      onPrimary: Colors.black, // Texto negro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Curvatura de las esquinas
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant_menu, size: 48.0), // Icono más grande
                        SizedBox(height: 8.0),
                        Text('Genera tu menu'), // Texto abajo del icono
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Define las pantallas para cada botón (igual que en el ejemplo anterior)

class CrearMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear tu menu'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla "Crear tu menu"'),
      ),
    );
  }
}

class AccedeMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accede a tu menu'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla "Accede a tu menu"'),
      ),
    );
  }
}

class ConfiguraMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configura tu menu'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla "Configura tu menu"'),
      ),
    );
  }
}

class GeneraMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genera tu menu'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla "Genera tu menu"'),
      ),
    );
  }
}
