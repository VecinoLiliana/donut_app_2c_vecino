// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:donut_app_2c_vecino/services/auth_services.dart' as outh; // Importación del servicio de autenticación (se renombra como 'outh' para usarlo más fácil)

// Clase LoginPage que es un StatefulWidget, ya que su estado (como cargando o error) cambiará dinámicamente
class LoginPage extends StatefulWidget {
  final Function(String) onLoginSuccess; // Callback para devolver el token al HomePage cuando el login sea exitoso

  const LoginPage({super.key, required this.onLoginSuccess}); // Constructor que requiere la función onLoginSuccess

  @override
  State<LoginPage> createState() => _LoginPageState(); // Crea el estado del widget
}

// Estado asociado al LoginPage
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Clave única para el formulario, permite validar y gestionar el formulario
  String email = ''; // Variable para almacenar el correo ingresado
  String password = ''; // Variable para almacenar la contraseña ingresada
  bool isLoading = false; // Indica si la app está en proceso de login (muestra loading spinner)
  String? errorMsg; // Mensaje de error en caso de fallo de login o error de conexión

  // Función asíncrona que realiza el login llamando al AuthService
  Future<void> login() async {
    // Cambia el estado a cargando y limpia el mensaje de error
    setState(() {
      isLoading = true;
      errorMsg = null;
    });

    // Llama al AuthService para intentar iniciar sesión con las credenciales
    final token = await outh.AuthService().login(email, password);

    // Termina el loading (independientemente si fue exitoso o no)
    setState(() {
      isLoading = false;
    });

    // Si se recibió un token (login exitoso), se llama al callback y se regresa al HomePage
    if (token != null) {
      widget.onLoginSuccess(token); // Devuelve el token al HomePage
    } else {
      // Si falló el login, se muestra un mensaje de error en pantalla
      setState(() {
        errorMsg = 'Credenciales incorrectas o error de conexión';
      });
    }
  }

  // Método build: construye la UI del LoginPage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fondo con un degradado rosa bonito
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC1CC), Color(0xFFFFB6C1)], // Degradado de colores rosas
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Centra todo el contenido en la pantalla
        child: Center(
          // Hace scroll si la pantalla es pequeña para evitar desbordes
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen de un donut como logo de bienvenida
                Image.asset(
                  "lib/images/strawberry_donut.png",
                  height: 100,
                ),
                const SizedBox(height: 20), // Espaciado debajo de la imagen
                // Tarjeta blanca donde irá el formulario de login
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey, // Asigna la clave del formulario
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Título de bienvenida
                          const Text(
                            'Bienvenido de nuevo 🎀 ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          const SizedBox(height: 16), // Espacio después del título

                          // Campo de texto para ingresar el correo electrónico
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.email_outlined), // Icono al inicio del campo
                            ),
                            onChanged: (val) => email = val, // Actualiza la variable email en tiempo real
                            validator: (val) =>
                                val != null && val.contains('@') ? null : 'Correo inválido', // Valida formato simple de correo
                          ),
                          const SizedBox(height: 12), // Espacio entre campos

                          // Campo de texto para ingresar la contraseña
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            obscureText: true, // Oculta el texto para seguridad
                            onChanged: (val) => password = val, // Actualiza la variable password en tiempo real
                            validator: (val) =>
                                val != null && val.length >= 4 ? null : 'Contraseña muy corta', // Valida longitud mínima
                          ),
                          const SizedBox(height: 20), // Espacio después de los campos de texto

                          // Si hay un mensaje de error, lo muestra en rojo
                          if (errorMsg != null)
                            Text(errorMsg!,
                                style: const TextStyle(color: Colors.redAccent)),
                          const SizedBox(height: 16), // Espacio antes del botón

                          // Botón de iniciar sesión
                          SizedBox(
                            width: double.infinity, // Que ocupe todo el ancho disponible
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.pinkAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading // Si está cargando, el botón se deshabilita
                                  ? null
                                  : () {
                                      // Si no está cargando, valida el formulario
                                      if (_formKey.currentState!.validate()) {
                                        login(); // Si el formulario es válido, intenta loguear
                                      }
                                    },
                              child: isLoading
                                  ? const CircularProgressIndicator(color: Colors.pink) // Spinner si está cargando
                                  : const Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(fontSize: 16),
                                    ), // Texto normal si no está cargando
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
