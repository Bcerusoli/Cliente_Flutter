
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://toncipinto.nur.edu/api';

  
  // Cliente
  static Future<http.Response> registerClient(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('$baseUrl/cliente/registro'),
      body: jsonEncode(data),
      headers: _headers(),
    );
  }

    static Future<http.Response> loginClient(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('$baseUrl/cliente/login'),
      body: jsonEncode(data),
      headers: _headers(),
    );
  }

  // Arrendatario
  static Future<http.Response> registerArrendatario(Map<String, dynamic> data) {
    return http.post(Uri.parse('$baseUrl/arrendatario/registro'), body: jsonEncode(data), headers: _headers());
  }

  static Future<http.Response> loginArrendatario(Map<String, dynamic> data) {
    return http.post(Uri.parse('$baseUrl/arrendatario/login'), body: jsonEncode(data), headers: _headers());
  }


  static Future<http.Response> searchLugares(Map<String, dynamic> data) {
    return http.post(Uri.parse('$baseUrl/lugares/search'), body: jsonEncode(data), headers: _headers());
  }


  static Future<http.Response> advancedSearchLugares(Map<String, dynamic> data) async {
    print('Enviando solicitud POST a /lugares/advancedsearch con datos: $data');
    final response = await http.post(
      Uri.parse('$baseUrl/lugares/advancedsearch'),
      body: jsonEncode(data),
      headers: _headers(),
    );
    print('Respuesta recibida: ${response.statusCode}');
    print('Cuerpo de la respuesta: ${response.body}');
    return response;
  }

  static Future<http.Response> getLugar(int id) {
    return http.get(Uri.parse('$baseUrl/lugares/$id'), headers: _headers());
  }

  static Future<http.Response> getLugaresArrendatario(int arrendatarioId) {
    return http.get(Uri.parse('$baseUrl/lugares/arrendatario/$arrendatarioId'), headers: _headers());
  }

  static Future<http.Response> createLugar(Map<String, dynamic> data) {
    return http.post(Uri.parse('$baseUrl/lugares'), body: jsonEncode(data), headers: _headers());
  }

  static Future<http.Response> addFotoLugar(int id, Map<String, dynamic> data) {
    return http.post(Uri.parse('$baseUrl/lugares/$id/foto'), body: jsonEncode(data), headers: _headers());
  }

  // Reservas
  static Future<http.Response> getReservasCliente(int clienteId) {
    return http.get(Uri.parse('$baseUrl/reservas/cliente/$clienteId'), headers: _headers());
  }

  static Future<http.Response> createReserva(Map<String, dynamic> data) {
    return http.post(Uri.parse('$baseUrl/reservas'), body: jsonEncode(data), headers: _headers());
  }

  static Future<http.Response> getReservasLugar(int lugarId) {
    return http.get(Uri.parse('$baseUrl/reservas/lugar/$lugarId'), headers: _headers());
  }
  
    static Future<http.Response> postReserva(Map<String, dynamic> data) async {
    print('Enviando reserva a /reservas con datos: $data');
    final response = await http.post(
      Uri.parse('$baseUrl/reservas'),
      body: jsonEncode(data),
      headers: _headers(),
    );
    print('Respuesta recibida: ${response.statusCode}');
    print('Cuerpo de la respuesta: ${response.body}');
    return response;
  }

  static Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
    };
  }
}