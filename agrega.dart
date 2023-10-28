import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'menu.dart';

class SubOptionInfo {
  final String foodType;
  final String subOptionName;
  final String subOptionImage;

  SubOptionInfo({
    required this.foodType,
    required this.subOptionName,
    required this.subOptionImage,
  });
}

class AgregaScreen extends StatefulWidget {
  final SubOptionInfo subOptionInfo;

  const AgregaScreen({Key? key, required this.subOptionInfo}) : super(key: key);

  @override
  _AgregaScreenState createState() => _AgregaScreenState();
}

class _AgregaScreenState extends State<AgregaScreen> {
  final List<MenuItemMenu> localItemList = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuState = Provider.of<MenuState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agrega/Subopcion'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _image != null
                    ? FadeInImage(
                  placeholder: AssetImage('assets/placeholder.png'), // Agrega una imagen de relleno
                  image: FileImage(_image!),
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : GestureDetector(
                  onTap: _pickImage,
                  child: Icon(
                    Icons.add,
                    size: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'DESCRIPCIÓN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nombre del Producto'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Añade una descripción'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Precio', prefixText: '\$'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text;
                      final description = descriptionController.text;
                      final price = double.tryParse(priceController.text) ?? 0.0;

                      if (name.isNotEmpty && price > 0) {
                        final menuItem = MenuItemMenu(
                          name: name,
                          description: description,
                          price: price,
                          image: _image != null ? _image!.path : "",
                        );

                        final sectionName = widget.subOptionInfo.foodType;
                        final matchingSection = menuState.menuSections.firstWhere(
                              (section) => section.name == sectionName,
                          orElse: () {
                            final newSection = MenuSection(name: sectionName, items: []);
                            menuState.addSection(newSection);
                            return newSection;
                          },
                        );

                        matchingSection.items.add(menuItem);

                        setState(() {
                          localItemList.add(menuItem);
                          _image = null;
                        });

                        nameController.clear();
                        descriptionController.clear();
                        priceController.clear();
                      }
                    },
                    child: const Text('Agregar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccedeMenuScreen(menuItems: localItemList)),
                      );
                    },
                    child: const Text('Visualizar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
