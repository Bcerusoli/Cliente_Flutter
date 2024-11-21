import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final Map<String, dynamic> lugar = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(lugar['nombre']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Muestra la primera foto más grande
              Image.network(
                lugar['fotos'].isNotEmpty ? lugar['fotos'][0]['url'] : 'https://via.placeholder.com/600',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              // Muestra las demás fotos pequeñas
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: lugar['fotos'].map<Widget>((foto) {
                    return GestureDetector(
                      onTap: () {
                        // Muestra la foto más grande al hacer click
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Image.network(foto['url']),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(
                          foto['url'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                lugar['nombre'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(lugar['descripcion']),
              SizedBox(height: 16),
              Text('Capacidad: ${lugar['cantPersonas']} personas'),
              Text('Camas: ${lugar['cantCamas']}'),
              Text('Baños: ${lugar['cantBanios']}'),
              Text('Habitaciones: ${lugar['cantHabitaciones']}'),
              Text('Wi-Fi: ${lugar['tieneWifi'] == 1 ? 'Sí' : 'No'}'),
              Text('Parqueo: ${lugar['cantVehiculosParqueo']} vehículos'),
              Text('Precio por noche: \$${lugar['precioNoche']}'),
              Text('Costo de limpieza: \$${lugar['costoLimpieza']}'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  
                  Navigator.pushNamed(context, '/confirm_reservation', arguments: lugar);
                },
                child: Text('Reservar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}