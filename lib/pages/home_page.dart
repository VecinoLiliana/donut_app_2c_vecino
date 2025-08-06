// Importación de las Tabs de productos (cada una mostrará productos específicos)
import 'package:donut_app_2c_vecino/tabs/burger_tab.dart';
import 'package:donut_app_2c_vecino/tabs/donnut_tab.dart';
import 'package:donut_app_2c_vecino/tabs/pancakes_tab.dart';
import 'package:donut_app_2c_vecino/tabs/pizza_tab.dart';
import 'package:donut_app_2c_vecino/tabs/smoothie_tab.dart';

// Widget que representa un ícono/tab personalizado
import 'package:donut_app_2c_vecino/utils/my_tab.dart';

// Flutter framework UI
import 'package:flutter/material.dart';

// Importación de las otras páginas de la app
import 'package:donut_app_2c_vecino/pages/supermarket_page.dart';
import 'package:donut_app_2c_vecino/pages/login_page.dart';

// HomePage es un StatefulWidget porque manejará estados como el carrito, token, etc.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estado asociado al HomePage
class _HomePageState extends State<HomePage> {
  // Lista de pestañas (íconos personalizados) que se mostrarán en la TabBar
  List<Widget> myTabs = [
    MyTab(iconPath: 'lib/icons/donut.png'),
    MyTab(iconPath: 'lib/icons/burger.png'),
    MyTab(iconPath: 'lib/icons/smoothie.png'),
    MyTab(iconPath: 'lib/icons/pancakes.png'),
    MyTab(iconPath: 'lib/icons/pizza.png'),
  ];

  // Variables del carrito de compras
  int itemCount = 0; // Número total de items en el carrito
  double totalPrice = 0.0; // Precio total de los productos en el carrito

  // Función que se ejecuta al añadir un producto al carrito
  void addToCart(double price) {
    setState(() {
      itemCount++;        // Aumenta en 1 la cantidad de productos
      totalPrice += price; // Suma el precio del producto al total
    });
  }

  // Variable donde se almacenará el token JWT después de iniciar sesión
  String? bearerToken;

  // Método que se ejecuta cuando el login es exitoso
  void handleLoginSuccess(String token) {
    setState(() {
      bearerToken = token; // Guarda el token en el estado
    });
    // Aquí podrías almacenar el token en almacenamiento seguro si deseas
  }

  // Método para abrir la pantalla de Login y esperar a recibir el token JWT
  Future<void> openLoginPage() async {
    final token = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          onLoginSuccess: (token) {
            Navigator.pop(context, token); // Retorna el token al cerrar la LoginPage
          },
        ),
      ),
    );
    if (token != null) {
      handleLoginSuccess(token); // Si se recibió un token, lo guarda en el estado
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( // Controlador de Tabs que gestiona la navegación entre ellas
      length: myTabs.length, // Número de pestañas (5 en este caso)
      child: Scaffold( // Estructura principal de la pantalla
        drawer: Drawer( // Menú lateral (hamburger menu)
          child: ListView(
            padding: EdgeInsets.zero, // Sin padding
            children: [
              const DrawerHeader( // Encabezado del Drawer (fijo)
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 113, 148), // Color rosa
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile( // Opción de ir al SuperMarketPage
                leading: const Icon(Icons.store),
                title: const Text('SuperMarket'),
                onTap: () {
                  Navigator.pop(context); // Cierra el Drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuperMarketPage(
                        bearerToken: bearerToken, // Pasa el token al SuperMarketPage
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        appBar: AppBar( // Barra superior (AppBar)
          backgroundColor: Colors.transparent, // Fondo transparente
          leading: Builder( // Icono de menú (hamburger)
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800]), // Icono en color gris oscuro
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer al presionar el botón
              },
            ),
          ),
          actions: [ // Acciones a la derecha del AppBar
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: IconButton(
                icon: Icon(Icons.person), // Icono de usuario (Login)
                onPressed: openLoginPage, // Abre la pantalla de Login al presionar
                tooltip: bearerToken == null
                    ? 'Iniciar sesión' // Si no hay token, muestra "Iniciar sesión"
                    : 'Cambiar usuario', // Si hay token, muestra "Cambiar usuario"
              ),
            )
          ],
        ),
        body: Column( // Cuerpo de la página
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36, vertical: 18), // Padding del título
              child: Row(
                children: [
                  const Text("I want to ", style: TextStyle(fontSize: 32)), // Texto normal
                  Text( // Texto con estilo especial (Eat)
                    "Eat",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, // Subrayado
                      color: Colors.pinkAccent[800], // Color rosa fuerte
                    ),
                  )
                ],
              ),
            ),
            TabBar(tabs: myTabs), // TabBar que muestra los íconos de las pestañas (donut, burger, etc.)
            Expanded(
              child: TabBarView( // Contenido que se mostrará al cambiar de pestaña
                children: [
                  DonnutTab(onAddToCart: addToCart), // Pasa la función addToCart a cada Tab
                  BurgerTab(onAddToCart: addToCart),
                  SmoothieTab(onAddToCart: addToCart),
                  PancakesTab(onAddToCart: addToCart),
                  PizzaTab(onAddToCart: addToCart),
                ],
              ),
            ),
            // Sección inferior (footer) que muestra la cantidad de items y precio total
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacio entre los elementos
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$itemCount Items | \$${totalPrice.toStringAsFixed(2)}', // Muestra cantidad y precio
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Delivery Charges Included", // Texto fijo debajo
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton( // Botón para ir al carrito
                    onPressed: () {
                      if (itemCount > 0) { // Solo si hay productos en el carrito
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ir al carrito')), // Muestra un SnackBar temporal
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Botón color rosa
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'View Cart', // Texto del botón
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
