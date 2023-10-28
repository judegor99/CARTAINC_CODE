import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'menu.dart';

class ConfiguraMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuState = context.watch<MenuState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Configura tu menú'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/FONDO_MENU.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: menuState.menuSections.length,
          itemBuilder: (context, sectionIndex) {
            final menuSection = menuState.menuSections[sectionIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    menuSection.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: menuSection.items.length,
                  itemBuilder: (context, itemIndex) {
                    final menuItemMenu = menuSection.items[itemIndex];

                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'Eliminar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          // Elimina el elemento del menú
                          menuSection.items.remove(menuItemMenu);
                          // Notifica a los oyentes del cambio en el estado
                          menuState.notifyListeners();
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          // Cambia la propiedad "oculto" en función de si se toca el elemento
                          menuItemMenu.oculto = !menuItemMenu.oculto;
                          // Notifica a los oyentes del cambio en el estado
                          menuState.notifyListeners();
                        },
                        child: Card(
                          margin: EdgeInsets.all(8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Opacity(
                            opacity: menuItemMenu.oculto ? 0.5 : 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(menuItemMenu.image)),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        menuItemMenu.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        menuItemMenu.description,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '\$${menuItemMenu.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
