class Product {
final int id;
final String name;
final double price;
final double stock;

  Product({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.stock});

  //Crea un objeto de Product
  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json[ 'productId'] ?? json['idProducto'] ?? 0,
      name: json[ 'name'] ?? json['nombre'] ?? 0,
      price: (json[ 'price'] ?? json['precioVenta'] ?? 0).toDouble(),
      stock: json[ 'stock'] ?? json['cantidadStock'] ?? 0,);
  }
}