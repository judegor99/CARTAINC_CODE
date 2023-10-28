import 'dart:io';
import 'package:carta_inc/menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GenerateMenuScreen extends StatefulWidget {
  GenerateMenuScreen({Key? key}) : super(key: key);

  @override
  _GenerateMenuScreenState createState() => _GenerateMenuScreenState();
}

class _GenerateMenuScreenState extends State<GenerateMenuScreen> {
  final restaurantNameController = TextEditingController();
  File? restaurantLogoFile;

  Future<void> _pickRestaurantLogo() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        restaurantLogoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _generateAndPrintPDF(BuildContext context) async {
    final pdf = pw.Document();

    final menuState = context.read<MenuState>();

    if (menuState.menuSections.isEmpty) {
      print('No hay secciones en el menú.');
      return;
    }

    final otf = await rootBundle.load('assets/fonts/Quantum.otf');
    final font = pw.Font.ttf(otf);

    // Tamaño cuadrado para las imágenes
    final imageSize = 80.0;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              if (restaurantLogoFile != null)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.RichText(
                      text: pw.TextSpan(
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: <pw.TextSpan>[
                          pw.TextSpan(
                            text: restaurantNameController.text.toUpperCase(),
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Image(
                      pw.MemoryImage(restaurantLogoFile!.readAsBytesSync()),
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              pw.SizedBox(height: 20),
              for (var menuSection in menuState.menuSections)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    if (menuSection != menuState.menuSections.first)
                      pw.Divider(),
                    pw.Text(
                      menuSection.name.toUpperCase(),
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    for (var item in menuSection.items)
                      pw.Container(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Image(
                              pw.MemoryImage(File(item.image).readAsBytesSync()),
                              width: imageSize,
                              height: imageSize,
                            ),
                            pw.SizedBox(width: 20), // Separación entre imagen y texto
                            pw.Expanded(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        item.name.toUpperCase(),
                                        style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                        '\$${item.price.toStringAsFixed(2)}',
                                        style: pw.TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Text(
                                    item.description,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
    );

    final directory = (await getApplicationDocumentsDirectory()).path;
    final pdfFile = File('$directory/menu.pdf');
    await pdfFile.writeAsBytes(await pdf.save());

    await Printing.sharePdf(bytes: pdfFile.readAsBytesSync(), filename: 'menu.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final menuState = context.watch<MenuState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Genera y Visualiza Menú'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () => _generateAndPrintPDF(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: restaurantNameController,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'Nombre del Restaurante',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickRestaurantLogo,
                ),
              ],
            ),
          ),
          if (restaurantLogoFile != null)
            Image.file(
              restaurantLogoFile!,
              height: 150,
            ),
          Expanded(
            child: ListView(
              children: [
                for (var menuSection in menuState.menuSections)
                  for (var item in menuSection.items)
                    Card(
                      elevation: 3,
                      margin: EdgeInsets.all(8),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.file(
                              File(item.image),
                              width: 80,
                              height: 80,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text(item.description,
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 3),
                                  Text('\$${item.price.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}