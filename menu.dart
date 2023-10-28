import 'dart:io';
import 'package:carta_inc/crea.dart';
import 'package:carta_inc/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuItemMenu {
  final String name;
  final String description;
  final double price;
  final String image;
  bool oculto;

  MenuItemMenu({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.oculto = false,
  });
}

class MenuSection {
  final String name;
  final List<MenuItemMenu> items;

  MenuSection({
    required this.name,
    required this.items,
  });
}

class MenuState extends ChangeNotifier {
  String restaurantName = 'Nombre del Restaurante';
  String? restaurantLogo;
  Set<String> sectionsWithItems = <String>{};
  List<MenuSection> menuSections = [];

  int get itemCount =>
      menuSections.fold(0, (total, section) => total + section.items.length);

  void addSection(MenuSection section) {
    menuSections.add(section);
    notifyListeners();
  }

  void addSectionWithName(String sectionName) {
    if (!sectionsWithItems.contains(sectionName)) {
      final section = MenuSection(name: sectionName, items: []);
      menuSections.add(section);
      sectionsWithItems.add(sectionName);
      notifyListeners();
    }
  }

  void addItemToSection(MenuItemMenu item, int sectionIndex) {
    menuSections[sectionIndex].items.add(item);
    notifyListeners();
  }

  void setRestaurantLogo(String? logoPath) {
    restaurantLogo = logoPath;
    notifyListeners();
  }
}

class AccedeMenuScreen extends StatelessWidget {
  final List<MenuItemMenu> menuItems;
  const AccedeMenuScreen({required this.menuItems, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuState = context.watch<MenuState>();
    print('Total de elementos en el menú: ${menuState.itemCount}');

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        ),
        actions: [
          Row(
            children: [
              const SizedBox(),
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreaMenuScreen()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
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
                  child: Center(
                    child: Text(
                      menuSection.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuSection.items.length,
                  itemBuilder: (context, itemIndex) {
                    final menuItemMenu = menuSection.items[itemIndex];

                    if (!menuItemMenu.oculto) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(menuItemMenu.image)),
                                fit: BoxFit.cover,
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  menuItemMenu.description,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '\$${menuItemMenu.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(); // Elemento oculto
                    }
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
