import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_results_screen.dart';
import 'screens/place_details_screen.dart';
import 'screens/confirm_reservation_screen.dart';
import 'screens/reservations_screen.dart';
import 'screens/advanced_search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AirBNB Clone',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/search_results': (context) => SearchResultsScreen(),
        '/place_details': (context) => PlaceDetailsScreen(),
        '/confirm_reservation': (context) => ConfirmReservationScreen(),
        '/reservations': (context) => ReservationsScreen(),
        '/advanced_search': (context) => AdvancedSearchScreen(), 
      },
    );
  }
}