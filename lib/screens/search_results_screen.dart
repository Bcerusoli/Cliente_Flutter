import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResultsScreen extends StatefulWidget {
  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool isMapView = false;

  @override
  Widget build(BuildContext context) {
    
    final argumentos = ModalRoute.of(context)!.settings.arguments;

    List<dynamic> lugares;
    if (argumentos is Map<String, dynamic> && argumentos.containsKey('lugares')) {
      lugares = argumentos['lugares'] as List<dynamic>;
    } else if (argumentos is List<dynamic>) {
      lugares = argumentos;
    } else {
      throw Exception('Argumentos inválidos pasados a SearchResultsScreen');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                isMapView = !isMapView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isMapView ? buildMapView(lugares) : buildListView(lugares),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isMapView = !isMapView;
                });
              },
              child: Text(isMapView ? 'Vista de lista' : 'Vista de mapa'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListView(List<dynamic> lugares) {
    return ListView.builder(
      itemCount: lugares.length,
      itemBuilder: (context, index) {
        final lugar = lugares[index];
        final String primeraFoto = lugar['fotos'].isNotEmpty ? lugar['fotos'][0]['url'] : 'https://via.placeholder.com/150';

        return ListTile(
          leading: Image.network(primeraFoto),
          title: Text(lugar['nombre']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lugar['descripcion']),
              Text('Capacidad: ${lugar['cantPersonas']} personas'),
            ],
          ),
          trailing: Text('\$${lugar['precioNoche']}/noche'),
          onTap: () {
            Navigator.pushNamed(context, '/place_details', arguments: lugar);
          },
        );
      },
    );
  }

  Widget buildMapView(List<dynamic> lugares) {
    Set<Marker> markers = lugares.map((lugar) {
      return Marker(
        markerId: MarkerId(lugar['id'].toString()),
        position: LatLng(double.parse(lugar['latitud']), double.parse(lugar['longitud'])),
        infoWindow: InfoWindow(
          title: lugar['nombre'],
          snippet: '\$${lugar['precioNoche']}/noche',
        ),
      );
    }).toSet();

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(double.parse(lugares[0]['latitud']), double.parse(lugares[0]['longitud'])),
        zoom: 12,
      ),
      markers: markers,
    );
  }
}
