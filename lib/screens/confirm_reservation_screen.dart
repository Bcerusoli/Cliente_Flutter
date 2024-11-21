import 'package:flutter/material.dart';
import 'package:proyectomoviles/services/api_service.dart';

class ConfirmReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic>? args =
        arguments is Map<String, dynamic> ? arguments : null;

    print('Argumentos recibidos: $args'); 

    
    if (args == null || args['lugar'] == null || args['fechaInicio'] == null || args['fechaFin'] == null) {
      print('Faltan datos para confirmar la reserva'); 
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Faltan datos para confirmar la reserva.'),
        ),
      );
    }

    final Map<String, dynamic> lugar = args['lugar'];
    final DateTime fechaInicio = DateTime.parse(args['fechaInicio']);
    final DateTime fechaFin = DateTime.parse(args['fechaFin']);

    print('Lugar seleccionado: $lugar'); 
    print('Fecha de llegada: $fechaInicio'); 
    print('Fecha de salida: $fechaFin'); 


    final int cantidadNoches = fechaFin.difference(fechaInicio).inDays;
    final double precioPorNoche = double.parse(lugar['precioNoche'].toString());
    final double costoLimpieza = double.parse(lugar['costoLimpieza'].toString());
    final double cobroServicio = 10.00; 
    final double total = (cantidadNoches * precioPorNoche) + costoLimpieza + cobroServicio;

    print('Cantidad de noches: $cantidadNoches'); 
    print('Precio total: \$${total.toStringAsFixed(2)}'); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar Reserva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lugar['nombre'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Precio por noche: \$${precioPorNoche.toStringAsFixed(2)}'),
            Text('Cantidad de noches: $cantidadNoches'),
            Text('Costo de limpieza: \$${costoLimpieza.toStringAsFixed(2)}'),
            Text('Cobro por el servicio: \$${cobroServicio.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                print('Enviando reserva a la API...'); 

                // Manda la reserva a la API
                final response = await ApiService.createReserva({
                  'lugar_id': lugar['id'],
                  'fechaInicio': fechaInicio.toIso8601String(),
                  'fechaFin': fechaFin.toIso8601String(),
                  'precioTotal': total.toStringAsFixed(2),
                  'precioLimpieza': costoLimpieza.toStringAsFixed(2),
                  'precioNoches': (cantidadNoches * precioPorNoche).toStringAsFixed(2),
                  'precioServicio': cobroServicio.toStringAsFixed(2),
                });

                print('Respuesta de la API de reserva: ${response.statusCode}'); 

                if (response.statusCode == 200) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reserva confirmada')),
                  );
                  Navigator.pop(context);
                } else {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al confirmar la reserva')),
                  );
                }
              },
              child: Text('Confirmar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}