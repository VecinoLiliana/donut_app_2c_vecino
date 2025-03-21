import 'package:donut_app_2c_vecino/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class SmoothieTab extends StatelessWidget {
  final Function(double) onAddToCart;
  //lista de donas
  final List donutsOnSale = [
    // [ donutFlavor, donutText, donutPrice, donutColor, imageName ]
    ["Strawberry", "Cassava Roots","75", Colors.red, "lib/images/fresa.png"],
    ["Avocado", "Báuli","95", Colors.lightGreen, "lib/images/palta.png"],
    ["Mango", "Mora mora","99", Colors.amber, "lib/images/mango.png"],
    ["Apple", "Izlah","130", Colors.indigo, "lib/images/manzana.png"],

    ["Strawberry", "Cassava Roots","75", Colors.red, "lib/images/fresa.png"],
    ["Avocado", "Báuli","95", Colors.lightGreen, "lib/images/palta.png"],
    ["Mango", "Mora mora","99", Colors.amber, "lib/images/mango.png"],
    ["Apple", "Izlah","130", Colors.indigo, "lib/images/manzana.png"],
  ];
  SmoothieTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    // Widget para usar cuadricula
    return GridView.builder(
      // Cuántos elementos hay en una cuadricula
      itemCount: donutsOnSale.length,
      padding: EdgeInsets.all(12),
      // Prepa 1. Cómo se verán los elementos.
      gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          // Cuántas columnas
          crossAxisCount: 2,
          //Relación de aspecto (proporción)
          childAspectRatio: 1 / 1.5,
        ),
      
      itemBuilder: (context, index){
        // Cada elemento individual
        return DonnutTile(
        donnutFlavor: donutsOnSale[index][0],
        donnutText: donutsOnSale[index][1],
        donnutPrice: donutsOnSale [index][2],
        donnutColor: donutsOnSale[index][3],
        imageName: donutsOnSale[index][4],

        onAddToCart: () {
             double price = double.tryParse(donutsOnSale[index][2]) ?? 0;
             onAddToCart(price);
        },
        );
      },
    );
  }
}
