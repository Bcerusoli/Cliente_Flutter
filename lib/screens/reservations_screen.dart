
import 'package:flutter/material.dart';

class ReservationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservations')),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Place Name'),
            subtitle: Text('Reservation Date'),
            trailing: Text('\$350'),
          );
        },
      ),
    );
  }
}