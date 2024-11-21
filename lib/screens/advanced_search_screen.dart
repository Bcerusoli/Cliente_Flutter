import 'package:flutter/material.dart';
import 'package:proyectomoviles/services/api_service.dart';
import 'dart:convert';

class AdvancedSearchScreen extends StatefulWidget {
  @override
  _AdvancedSearchScreenState createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();
  final TextEditingController guestsController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController cantPersonasController = TextEditingController();
  final TextEditingController precioNocheController = TextEditingController();

  @override
  void dispose() {
    
    cityController.dispose();
    checkInDateController.dispose();
    checkOutDateController.dispose();
    guestsController.dispose();
    nombreController.dispose();
    descripcionController.dispose();
    cantPersonasController.dispose();
    precioNocheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Búsqueda Avanzada')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'Ciudad'),
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: checkInDateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de llegada (YYYY-MM-DD)',
                hintText: 'Ejemplo: 2024-12-01',
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: checkOutDateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de salida (YYYY-MM-DD)',
                hintText: 'Ejemplo: 2024-12-10',
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: guestsController,
              decoration: const InputDecoration(labelText: 'Número de huéspedes'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: cantPersonasController,
              decoration: const InputDecoration(labelText: 'Cantidad de Personas'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            
            TextField(
              controller: precioNocheController,
              decoration: const InputDecoration(labelText: 'Precio por Noche'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () async {
                
                if (
                  cityController.text.isEmpty &&
                  checkInDateController.text.isEmpty &&
                  checkOutDateController.text.isEmpty &&
                  guestsController.text.isEmpty &&
                  nombreController.text.isEmpty &&
                  descripcionController.text.isEmpty &&
                  cantPersonasController.text.isEmpty &&
                  precioNocheController.text.isEmpty
                ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, complete al menos un campo para la búsqueda')),
                  );
                  return;
                }

                
                final Map<String, dynamic> requestData = {};

                if (cityController.text.isNotEmpty) {
                  requestData['ciudad'] = cityController.text;
                }
                if (checkInDateController.text.isNotEmpty) {
                  requestData['fechaLlegada'] = checkInDateController.text;
                }
                if (checkOutDateController.text.isNotEmpty) {
                  requestData['fechaSalida'] = checkOutDateController.text;
                }
                if (guestsController.text.isNotEmpty) {
                  requestData['huespedes'] = int.parse(guestsController.text);
                }
                if (nombreController.text.isNotEmpty) {
                  requestData['nombre'] = nombreController.text;
                }
                if (descripcionController.text.isNotEmpty) {
                  requestData['descripcion'] = descripcionController.text;
                }
                if (cantPersonasController.text.isNotEmpty) {
                  requestData['cantPersonas'] = int.parse(cantPersonasController.text);
                }
                if (precioNocheController.text.isNotEmpty) {
                  requestData['precioNoche'] = double.parse(precioNocheController.text);
                }

                print('Datos de búsqueda avanzada: $requestData'); 

                try {
                  final response = await ApiService.advancedSearchLugares(requestData);
                  print('Respuesta de la API: ${response.statusCode}'); 

                  if (response.statusCode == 200) {
                    final List<dynamic> lugares = jsonDecode(response.body);
                    print('Lugares encontrados: $lugares'); 

                    Navigator.pushNamed(context, '/search_results', arguments: {
                      'lugares': lugares,
                      'ciudad': cityController.text,
                      'fechaInicio': checkInDateController.text,
                      'fechaFin': checkOutDateController.text,
                    });
                  } else {
                    String errorMsg = 'Error en la búsqueda avanzada';
                    try {
                      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
                      if (errorResponse.containsKey('message')) {
                        errorMsg = errorResponse['message'];
                      }
                    } catch (e) {
                      print('Error al parsear el mensaje de error: $e');
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMsg)),
                    );

                    print('Cuerpo de la respuesta de error: ${response.body}');
                  }
                } catch (e) {
                  print('Error al realizar la búsqueda avanzada: $e'); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ocurrió un error al realizar la búsqueda')),
                  );
                }
              },
              child: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}