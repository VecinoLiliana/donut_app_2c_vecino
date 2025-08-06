// Importa el paquete 'dart:convert' para decodificar JSON
import 'dart:convert';

// Importa el modelo de Product (donde defines cómo se estructura un producto)
import 'package:donut_app_2c_vecino/models/product.dart';

// Importa el paquete http para realizar peticiones REST
import 'package:http/http.dart' as http;

// Importa el servicio de autenticación (para obtener el token almacenado)
import 'package:donut_app_2c_vecino/services/auth_services.dart' as outh;

// Clase ProductService que gestiona las peticiones relacionadas con productos
class ProductService {

  // URL base de la API (Spring Boot backend)
  static const String baseUrl = "http://localhost:8090/market-app/api"; 
  

  // Método estático para obtener todos los productos
  static Future<List<Product>> getAllProducts() async {
    // Obtiene el token JWT desde el AuthService (almacenado en Secure Storage)
    final token = await outh.AuthService().getToken();

    // Realiza la petición GET al endpoint /products/all
    final response = await http.get(
      Uri.parse("$baseUrl/products/all"), // URL completa
      headers: {'Authorization': 'Bearer $token'}, // Añade el token en el header de autorización
    );

    // Si la respuesta fue exitosa (HTTP 200 OK)
    if (response.statusCode == 200) {
      // Decodifica el body de la respuesta (que viene como JSON) a una lista dinámica
      final List<dynamic> jsonData = json.decode(response.body);

      // Mapea cada elemento de la lista JSON a un objeto Product y lo retorna como una lista de productos
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      // Si ocurre un error en la respuesta, lanza una excepción
      throw Exception("Error al cargar productos");
    }
  }

  // Método estático para obtener productos filtrados por categoría
  static Future<List<Product>> getProductsByCategory(int categoryId) async {
    // Obtiene el token JWT desde el AuthService
    final token = await outh.AuthService().getToken();

    // Realiza la petición GET al endpoint /products/category/{categoryId}
    final response = await http.get(
      Uri.parse("$baseUrl/products/category/$categoryId"), // URL construida dinámicamente con el ID de la categoría
      headers: {'Authorization': 'Bearer $token'}, // Añade el token en el header de autorización
    );

    // Si la respuesta fue exitosa (HTTP 200 OK)
    if (response.statusCode == 200) {
      // Decodifica el body de la respuesta (que viene como JSON) a una lista dinámica
      final List<dynamic> jsonData = json.decode(response.body);

      // Mapea cada elemento de la lista JSON a un objeto Product y lo retorna como una lista de productos
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      // Si ocurre un error en la respuesta, lanza una excepción
      throw Exception("Error al cargar productos por categoría");
    }
  }
}
