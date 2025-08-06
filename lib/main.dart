// Importación de la página principal (HomePage) que se mostrará después del login
import 'package:donut_app_2c_vecino/pages/home_page.dart';

// Importación de Flutter UI
import 'package:flutter/material.dart';

// Importación de la página de login
import 'package:donut_app_2c_vecino/pages/login_page.dart';

// Función principal que arranca la aplicación
void main() {
  runApp(const MyApp()); // Ejecuta el widget raíz de la app (MyApp)
}

// Widget que representa la app cuando el usuario ya inició sesión (post-login)
class MyAppLoggedIn extends StatelessWidget {
  const MyAppLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la banda de debug
      title: 'Donut App', // Título de la app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Define el esquema de colores (Material Design 3)
        useMaterial3: true,
      ),
      home: const HomePage(), // Página principal de la app (HomePage)
    );
  }
}

// Widget raíz de la aplicación (pantalla inicial cuando aún no ha iniciado sesión)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la banda de debug
      title: 'Donut App', // Título de la app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Esquema de colores
        useMaterial3: true, // Usa Material Design 3
      ),
      // 👇 Aquí defines la pantalla inicial como LoginPage
      home: LoginPage(
        onLoginSuccess: (token) {
          // Esta función se ejecutará cuando el login sea exitoso
          // Cambia la aplicación para mostrar la HomePage en vez de LoginPage
          runApp(const MyAppLoggedIn()); // Reinicia la app cargando la versión post-login
        },
      ),
    );
  }
}
