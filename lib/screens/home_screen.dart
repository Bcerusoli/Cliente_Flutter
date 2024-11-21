import 'package:flutter/material.dart';
import 'package:proyectomoviles/services/api_service.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController guestsController = TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Buscar ciudad'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: guestsController,
              decoration: InputDecoration(labelText: 'Número de huéspedes'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: checkInDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de llegada ',
                hintText: 'Ejemplo: 2024-12-01',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 10),
            TextField(
              controller: checkOutDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de salida ',
                hintText: 'Ejemplo: 2024-12-10',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (checkInDateController.text.isEmpty || checkOutDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, ingrese ambas fechas')),
                  );
                  return;
                }

                final requestData = {
                  'search': cityController.text,
                  'fechaLlegada': checkInDateController.text,
                  'fechaSalida': checkOutDateController.text,
                  'huespedes': guestsController.text,
                };

                print('Datos de búsqueda: $requestData'); 

                final response = await ApiService.searchLugares(requestData);
                print('Respuesta de la API: ${response.statusCode}'); 

                if (response.statusCode == 200) {
                  final List<dynamic> lugares = jsonDecode(response.body);
                  print('Lugares encontrados: $lugares'); 

                  Navigator.pushNamed(context, '/search_results', arguments: {
                    'lugares': lugares,
                    'fechaInicio': checkInDateController.text,
                    'fechaFin': checkOutDateController.text,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error en la búsqueda')),
                  );
                }
              },
              child: Text('Buscar'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reservations');
              },
              child: Text('Ver Reservas'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/advanced_search');
              },
              child: Text('Búsqueda Avanzada'),
            ),
          ],
        ),
      ),
    );
  }
}