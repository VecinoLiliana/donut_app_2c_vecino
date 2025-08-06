// Importa el paquete 'dart:convert' para convertir datos JSON a Map y viceversa
import 'dart:convert';

// Importa el paquete 'http' para realizar peticiones HTTP (GET, POST, etc.)
import 'package:http/http.dart' as http;

// Importa 'flutter_secure_storage' para guardar datos sensibles de manera segura en el dispositivo
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Clase AuthService encargada de gestionar la autenticación (login, logout, obtener token)
class AuthService {
  // URL base del backend (Spring Boot) donde están las rutas de autenticación
  final String _baseUrl = "http://localhost:8090/market-app/api/auth"; // ← Cambia a 10.0.2.2 si es emulador Android

  // Instancia de Secure Storage para guardar el token JWT de manera segura en el dispositivo
  final _storage = FlutterSecureStorage();

  /// Método asíncrono que realiza el inicio de sesión
  /// Recibe correo y contraseña, y si son válidos, devuelve el token recibido desde la API
  Future<String?> login(String correo, String contrasena) async {
    // Construye la URL completa para la petición de login
    final url = Uri.parse('$_baseUrl/login');

    try {
      // Realiza una petición POST al endpoint de login con los datos del usuario
      final response = await http.post(
        url, // URL del endpoint
        headers: {'Content-Type': 'application/json'}, // Indica que se envía JSON
        body: jsonEncode({ // Convierte el cuerpo de la petición a JSON
          'correo': correo.trim(), // Elimina espacios en blanco accidentales
          'contrasena': contrasena.trim(),
        }),
      );

      // Imprime el status code (200, 400, etc.) para depuración
      print('Status code: ${response.statusCode}');
      // Imprime el cuerpo de la respuesta de la API (por ejemplo, {"token": "abc123"})
      print('Response body: ${response.body}');

      // Si el login fue exitoso (HTTP 200 OK)
      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta JSON a un Map
        final body = jsonDecode(response.body);
        // Extrae el token del Map (asume que viene como {"token": "abc123"})
        final token = body['token'];

        // Guarda el token en el almacenamiento seguro del dispositivo 🛡️
        await _storage.write(key: 'jwt_token', value: token);

        // Retorna el token para que la aplicación lo pueda usar
        return token;
      } else {
        // Si la respuesta no fue 200, imprime un mensaje de error
        print('Error en login: ${response.statusCode}');
        return null; // Retorna null indicando que el login falló
      }
    } catch (e) {
      // Si ocurre un error (por ejemplo, no se puede conectar al backend)
      print('Error al iniciar sesión: $e');
      return null; // Retorna null indicando que hubo un fallo en la conexión
    }
  }

  /// Método que recupera el token almacenado en secure storage
  /// Útil para verificar si el usuario ya tiene sesión activa
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token'); // Lee el token almacenado
  }

  /// Método que elimina el token del almacenamiento seguro (logout)
  /// Sirve para cerrar la sesión del usuario eliminando el token
  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token'); // Borra el token guardado
  }
}
