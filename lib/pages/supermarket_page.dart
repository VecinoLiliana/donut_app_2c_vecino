// Importaciones necesarias para el funcionamiento de la página
import 'package:donut_app_2c_vecino/models/category.dart'; // Modelo de categoría (lista de categorías)
import 'package:donut_app_2c_vecino/models/product.dart'; // Modelo de producto
import 'package:donut_app_2c_vecino/services/product_service.dart'; // Servicio que se conecta a la API para obtener productos
import 'package:flutter/material.dart'; // Flutter UI Framework

// Clase SuperMarketPage que es un StatefulWidget (porque va a cambiar su estado dinámicamente al cargar productos, etc.)
class SuperMarketPage extends StatefulWidget {
  final String? bearerToken;  // Parámetro opcional para recibir el token JWT (para futuras llamadas a APIs protegidas)

  // Constructor que recibe opcionalmente el bearerToken
  const SuperMarketPage({super.key, this.bearerToken});

  @override
  State<SuperMarketPage> createState() => _SuperMarketPageState(); // Crea el estado asociado a este widget
}

// Estado de la página SuperMarketPage
class _SuperMarketPageState extends State<SuperMarketPage> {
  List<Product> products = []; // Lista de productos que se mostrarán en la vista
  bool isLoading = true; // Variable de control para mostrar spinner de carga
  int? selectedCategoryId; // ID de la categoría seleccionada (para filtrar productos)

  // Método que se ejecuta automáticamente cuando se crea la página (ciclo de vida de Flutter)
  @override
  void initState() {
    super.initState();
    print("Bearer Token recibido: ${widget.bearerToken}");  // Imprime el token recibido (para debug)
    loadProducts(); // Carga los productos al iniciar (sin filtros de categoría)
  }

  // Método asíncrono que carga productos desde el servicio ProductService
  // Si se recibe un categoryId, filtra los productos por categoría, si no, carga todos
  Future<void> loadProducts({int? categoryId}) async {
    setState(() {
      isLoading = true; // Activa el loading spinner mientras se cargan los productos
    });
    try {
      // Llamada al servicio ProductService dependiendo si se seleccionó una categoría o no
      final fetchedProducts = categoryId == null
          ? await ProductService.getAllProducts() // Llama a la API para obtener todos los productos
          : await ProductService.getProductsByCategory(categoryId); // Filtra productos por categoría

      setState(() {
        products = fetchedProducts; // Guarda la lista de productos recibidos en el estado
      });
    } catch (e) {
      // Si ocurre un error al obtener productos, lo imprime y deja la lista vacía
      print("Error: $e");
      setState(() {
        products = [];
      });
    } finally {
      setState(() {
        isLoading = false; // Desactiva el spinner de carga sin importar si fue exitoso o hubo error
      });
    }
  }

  // Widget que construye el Dropdown para seleccionar categorías
  Widget buildDropdown() {
    return DropdownButton<int>(
      hint: const Text("Selecciona categoría"), // Texto inicial antes de seleccionar categoría
      value: selectedCategoryId, // Valor actualmente seleccionado
      onChanged: (value) {
        // Cuando el usuario selecciona una nueva categoría:
        setState(() {
          selectedCategoryId = value; // Guarda el ID de la categoría seleccionada
        });
        loadProducts(categoryId: value); // Vuelve a cargar los productos, ahora filtrando por la categoría seleccionada
      },
      items: categories.map((cat) {
        // Genera un listado de DropdownMenuItem a partir de la lista 'categories'
        return DropdownMenuItem<int>(
          value: cat.id, // El valor que se enviará al seleccionarlo
          child: Text(cat.name), // El nombre que se mostrará en el Dropdown
        );
      }).toList(), // Convierte la lista mapeada en una lista de Widgets
    );
  }

  // Widget que construye la tarjeta visual para cada producto
  Widget buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Espaciado externo de la tarjeta
      elevation: 4, // Sombra de la tarjeta (elevación visual)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
      child: ListTile(
        title: Text(product.name), // Nombre del producto
        subtitle: Text("Precio: \$${product.price} | Stock: ${product.stock}"), // Precio y stock del producto
        trailing: const Icon(Icons.shopping_cart_outlined), // Icono de carrito al final de la tarjeta
      ),
    );
  }

  // Método build principal que construye la UI completa de la página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SuperMarket'), // Título del AppBar
        backgroundColor: const Color.fromARGB(255, 218, 113, 148), // Color rosa personalizado
      ),
      body: Column(
        children: [
          // Widget desplegable para filtrar por categoría
          Padding(
            padding: const EdgeInsets.all(12), // Espaciado alrededor del Dropdown
            child: buildDropdown(), // Construye el Dropdown
          ),
          // Área que mostrará la lista de productos o el spinner de carga
          Expanded(
            child: isLoading // Si está cargando...
                ? const Center(child: CircularProgressIndicator()) // Muestra el spinner de carga
                : products.isEmpty // Si no hay productos cargados (lista vacía)
                    ? const Center(child: Text("No hay productos")) // Mensaje de "No hay productos"
                    : ListView.builder( // Si hay productos, muestra una lista desplazable de ellos
                        itemCount: products.length, // Cuántos productos hay en la lista
                        itemBuilder: (context, index) => // Construye cada tarjeta de producto
                            buildProductCard(products[index]),
                      ),
          ),
        ],
      ),
    );
  }
}
